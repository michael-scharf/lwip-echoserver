CC       = gcc
CFLAGS   = -O3 -pipe -Iinclude -Iinclude/ports/unix
LD       = ld
LDFLAGS  = $(LFLAGS)
LDLIBS   =
AR       = ar

SRCDIR   = src
BUILDDIR = build
BINDIR   = bin

BINNAME  = echoserver
LIBNAME  = lwip

PROGRAM  = $(BINDIR)/$(BINNAME)
LIBRARY  = $(BINDIR)/lib$(LIBNAME).a

rwildcard= $(foreach d,$(wildcard $1*), \
           $(call rwildcard,$d/,$2) \
           $(filter $(subst *,%,$2),$d))

SRC      = $(call rwildcard,$(SRCDIR)/,*.c)
#CCSRCS=$(filter %.c,$(SRCFILES))
OBJ      = $(patsubst $(SRCDIR)/%.c,$(BUILDDIR)/%.o,$(SRC))
DEPEND   = $(OBJ:.o=.dep)

.PHONY: all library clean

all : $(PROGRAM)

library : $(LIBRARY)

$(PROGRAM) : $(OBJ)
	mkdir -p $(dir $@)
	$(CC) -o $@ $^ $(LDFLAGS)

$(LIBRARY) : $(OBJ)
	mkdir -p $(dir $@)
	$(AR) csq $@ $^

$(BUILDDIR)/%.dep : $(SRCDIR)/%.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -MM -MT$(@:.dep=.o) -MF$@ $< 2>/dev/null

$(BUILDDIR)/%.o : $(SRCDIR)/%.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c -o $@ $<

clean :
	$(RM) -rf $(BINDIR) $(BUILDDIR)

ifneq ($(MAKECMDGOALS),clean)
-include $(DEPEND)
endif
