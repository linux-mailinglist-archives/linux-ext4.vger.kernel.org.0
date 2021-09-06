Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C19401B48
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Sep 2021 14:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241946AbhIFMhd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Sep 2021 08:37:33 -0400
Received: from THBLACKELECTRIC.COM ([207.244.97.128]:39226 "EHLO lsw.cs1local"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236783AbhIFMhd (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 6 Sep 2021 08:37:33 -0400
X-Greylist: delayed 2048 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Sep 2021 08:37:33 EDT
Received: from [72.29.63.102] (helo=localhost.localdomain)
        by lsw.cs1local with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <thb@b-tk.org>)
        id 1mNDKM-0002lp-Rx; Mon, 06 Sep 2021 12:02:19 +0000
Received: from thb by localhost.localdomain with local (Exim 4.94.2)
        (envelope-from <thb@b-tk.org>)
        id 1mNCzU-00015j-N2; Mon, 06 Sep 2021 11:40:44 +0000
Date:   Mon, 6 Sep 2021 11:40:44 +0000
From:   "Thaddeus H. Black" <thb@debian.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Dr. Tobias Quathamer" <toddy@debian.org>,
        linux-ext4@vger.kernel.org, debian-doc@lists.debian.org
Subject: [PATCH] filename.7: new manual page
Message-ID: <YTX+PEtj60O/TdMh@b-tk.org>
Reply-To: "Thaddeus H. Black" <thb@debian.org>, linux-man@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AViBTmudb+KI5xLR"
Content-Disposition: inline
X-Spam_score: -0.8
X-Spam_bar: /
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--AViBTmudb+KI5xLR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This email submits to the Linux man-pages project the new manual page
filename(7).  The manual page's groff source follows in patch format.

This email is copied to two other, relevant lists as a courtesy, but its
main target is the list <linux-man@vger.kernel.org>, whose archives are
at [https://www.spinics.net/lists/linux-man/].

CONTENTS

I.   NAME AND BRIEF DESCRIPTION
II.  HOW INFORMATION TO WRITE THE MANUAL PAGE HAS BEEN OBTAINED
III. WHY THE MANUAL PAGE HAS BEEN WRITTEN
IV.  DISTRIBUTIONS AND LOCALES
V.   GROFF SOURCE (IN PATCH FORMAT)

---------------------------------------------------------------------------
I.   NAME AND BRIEF DESCRIPTION
---------------------------------------------------------------------------

FILENAME(7)              Linux Programmer's Manual              FILENAME(7)

NAME
       filename - requirements and conventions for the naming of files

DESCRIPTION
       This  manual page sets forth requirements for and delineates conven=
=E2=80=90
       tions regarding filenames on a Linux system, where a filename is ei=
=E2=80=90
       ther  (as  the word suggests) the name of a regular file or the name
       of another object held by the system's filesystem such as  a  direc=
=E2=80=90
       tory, symbolic link, named pipe or device.

---------------------------------------------------------------------------
II.  HOW INFORMATION TO WRITE THE MANUAL PAGE HAS BEEN OBTAINED
---------------------------------------------------------------------------

The web page [https://www.kernel.org/doc/man-pages/patches.html] asks
how the information to write the manual page has been obtained.  I have
obtained the information in eight ways.

[1] From POSIX.1-2008, SUSv4, sects. 3.281, 3.282 and 4.13.
Excerpts follow.

3.281 Portable Filename

A filename consisting only of characters from the portable filename
character set.

Note:  Applications should avoid using filenames that have
the <hyphen-minus> character as the first character since this may cause
problems when filenames are passed as command line arguments.

3.282 Portable Filename Character Set

The set of characters from which portable filenames are constructed.

A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
a b c d e f g h i j k l m n o p q r s t u v w x y z
0 1 2 3 4 5 6 7 8 9 . _ -

The last three characters are the <period>, <underscore>, and
<hyphen-minus> characters, respectively.  See also Pathname.

4.13 Pathname Resolution

Pathname resolution is performed for a process to resolve a pathname to a
particular directory entry for a file in the file hierarchy....

Each filename in the pathname is located in the directory specified by its
predecessor (for example, in the pathname fragment a/b, file b is located
in directory a).  Pathname resolution shall fail if this cannot be
accomplished.  If the pathname begins with a <slash>, the predecessor of the
first filename in the pathname shall be taken to be the root directory of
the process (such pathnames are referred to as "absolute pathnames").  If
the pathname does not begin with a <slash>, the predecessor of the first
filename of the pathname shall be taken to be either the current working
directory of the process or for certain interfaces the directory identified
by a file descriptor passed to the interface (such pathnames are referred
to as "relative pathnames")....

The special filename dot shall refer to the directory specified by its
predecessor.  The special filename dot-dot shall refer to the parent
directory of its predecessor directory.  As a special case, in the root
directory, dot-dot may refer to the root directory itself....

A pathname consisting of a single <slash> shall resolve to the root
directory of the process.  A null pathname shall not be
successfully resolved....

[2] From the GNU Coreutils manual, ver. 8.32, especially chapter 2 and
sect. 10.1.1.  Excerpts follow.

2 Common options....

'--' Delimit the option list.  Later arguments, if any, are treated as
operands even if they begin with '-'.  For example, 'sort -- -r' reads from
the file named '-r'.

A single '-' operand is not really an option, though it looks like one.  It
stands for a file operand, and some tools treat it as standard input, or as
standard output if that is clear from the context....

10.1.1 Which files are listed....

By default, 'ls' lists files and the contents of any directories on the
command line, except that in directories it ignores files whose names start
with '.'.

[3] From dash(1) and bash(1).

[4] From the Unicode Standard, ver. 13.0,
especially Table 4-4. General Category.

[5] From the Unicode Character Database, which on a Debian GNU/Linux
system appears at /usr/share/unicode/UnicodeData.txt.  Incidentally, it
is because of the Unicode Character Database that the manual page calls
the period a full stop, the slash a solidus, the underscore a low line,
and the hyphen a hyphen-minus.

[6] From utf-8(7) and ascii(7).

[7] From a discussion on the debian-devel mailing list regarding MIME
types:  [https://lists.debian.org/debian-devel/2021/08/msg00557.html].

[8] From general experience as a Linux user and, since 2005, as
a Debian Developer.

---------------------------------------------------------------------------
III. WHY THE MANUAL PAGE HAS BEEN WRITTEN
---------------------------------------------------------------------------

The chief reason the manual page has been written is that newcomers
to Linux are often advised by experienced users, ad hoc, to avoid
unconventional filenames like "My Document.txt" in favor of,
say, "my-document.txt"; only nowhere in basic, conveniently accessible,
widely installed free documentation is it cogently explained which
filenames are conventional and, indeed, which are even legal.  Filenames
being ubiquitous, a proper introduction to them seems due; and anyway
between ext4(5) and utf-8(7) lies a gap.  Hence the new manual page,
which fills the gap.

---------------------------------------------------------------------------
IV.  DISTRIBUTIONS AND LOCALES
---------------------------------------------------------------------------

Since I do not use Arch or Fedora, but only Debian, I would appreciate
reviews from an Arch user and a Fedora user to ensure that the manual page
is as correct for those systems as it is for Debian.  The most likely
point of discrepancy regards MIME types:  see the manual page's
subsection "The full stop to introduce a format extension."

I would also appreciate a review by a native Chinese or Japanese speaker
of the manual page's section "LOCALES AND UNICODE," if any native Chinese
or Japanese speaker is reading.  (As far as I know, spaces in
local Chinese and Japanese filenames are as deprecated as they are, say,
in local French and German filenames.  However, I don't really know.
The manual page should not descend into a dissertation regarding every
possible locale, but I would at least like it to avoid inadvertent false
statements regarding local filenaming conventions in the
major Han/Kanji-using languages.)

---------------------------------------------------------------------------
V.   GROFF SOURCE (IN PATCH FORMAT)
---------------------------------------------------------------------------

--- /dev/null	2021-09-06 09:32:09.234024621 +0000
+++ b/man7/filename.7	2021-09-06 11:16:45.600516972 +0000
@@ -0,0 +1,519 @@
+.\" Copyright (C) 2021 Thaddeus H. Black <thb@debian.org>
+.\"
+.\" %%%LICENSE_START(VERBATIM)
+.\" Permission is granted to make and distribute verbatim copies of this
+.\" manual provided the copyright notice and this permission notice are
+.\" preserved on all copies.
+.\"
+.\" Permission is granted to copy and distribute modified versions of this
+.\" manual under the conditions for verbatim copying, provided that the
+.\" entire resulting derived work is distributed under the terms of a
+.\" permission notice identical to this one.
+.\"
+.\" Since the Linux kernel and libraries are constantly changing, this
+.\" manual page may be incorrect or out-of-date.  The author(s) assume no
+.\" responsibility for errors or omissions, or for damages resulting from
+.\" the use of the information contained herein.  The author(s) may not
+.\" have taken the same level of care in the production of this manual,
+.\" which is licensed free of charge, as they might when working
+.\" professionally.
+.\"
+.\" Formatted or processed versions of this manual, if unaccompanied by
+.\" the source, must acknowledge the copyright and authors of this work.
+.\" %%%LICENSE_END
+.\"
+.\" 2021-09-06, Thaddeus H. Black <thb@debian.org>
+.\"     Wrote the manual page's initial version.
+.\"
+.TH FILENAME 7 2021-09-06 "Linux" "Linux Programmer's Manual"
+.SH NAME
+.P
+filename \- requirements and conventions for the naming of files
+.SH DESCRIPTION
+.P
+This manual page sets forth requirements for and delineates conventions
+regarding filenames on a Linux system, where a
+.I filename
+is either (as the word suggests) the name of a regular file or the name of
+another object held by the system's filesystem such as a directory,
+symbolic link, named pipe or device.
+.SH LEGAL FILENAMES
+.P
+A filename on a Linux system can consist of almost any sequence of UTF-8
+characters or, indeed, almost any sequence of bytes.
+The exceptions are as follows.
+.SS Reserved characters
+.TP
+.B /
+The solidus is reserved to separate pathname components as for example in
+.IR /usr/share/doc ,
+each component being itself a filename.
+For this reason, no filename may include a solidus.
+More precisely, no filename may include the byte that, in ASCII and UTF-8,
+exclusively represents the solidus.
+.TP
+.B \e0
+The null character is reserved for the filesystem to append to terminate a
+filename's representation in memory.
+For this reason, no filename may include a null character.
+More precisely, no filename may include the byte that, in ASCII and UTF-8,
+exclusively represents the null character.
+(When appended by the filesystem to terminate a filename's representation
+in memory, the byte in question is called the
+.I terminating null
+.IR byte .
+Though familiar to\~C programmers, the terminating null byte is usually
+invisible to users.)
+.P
+Note that\~\fB\e0\fR, the null character (or null byte), differs
+from\~\fB0\fR, the printable digit-zero character.
+The null character (or null byte) is unprintable and registers in ASCII and
+UTF-8 as the eight-bit pattern\~0x00, whereas the printable digit zero
+registers as\~0x30 [see the \(lqHex\(rq column in
+.BR ascii (7)'s
+character table].
+Nothing prevents a filename from including a printable digit zero, as for
+instance the filename
+.I intel-m10-bmc.h
+from the kernel's source does.
+.SS Reserved names
+.TP
+.B .
+The filename consisting of a single full stop is reserved to represent the
+current directory.
+.TP
+.B ..
+The filename consisting of two full stops is reserved to represent the
+parent directory.
+.TP
+(empty)
+The empty filename, consisting of no bytes at all (except a terminating
+null byte), is not allowed.
+.P
+The aforementioned current and parent directories are the current
+.I working
+directory and its parent except when the\~\fB.\fR or\~\fB..\fR occurs in
+the middle or at the end of a pathname, in which case the current and
+parent directories are taken relative to preceding pathname elements.
+For example, if the current working directory were
+.IR /home/jsmith ,
+then
+.I ../rjones
+would mean
+.I /home/rjones
+but
+.I foo/bar/../baz
+would mean
+.IR /home/jsmith/foo/baz ,
+whereas
+.I foo/bar/./baz
+would mean
+.IR /home/jsmith/foo/bar/baz .
+.SS Long names
+.P
+No filename may exceed\~255 bytes in length, or\~256 bytes after counting
+the terminating null byte.
+.RB ( Reserved
+.B characters
+above explains the terminating null byte.)
+.SS Non-UTF-8 names
+.P
+Filenames need not consist of valid UTF-8 characters (although, except
+where a non-UTF-8 legacy encoding is in use, most filenames do).
+As long as the requirements of the preceding subsections are met, any
+sequence of bytes can legally serve as a filename.
+.SH CONVENTIONAL FILENAMES
+.P
+Merely because a filename is legal does not make its use advisable, though.
+Some legal filenames cause practical troubles.
+For example, the legal filenames
+.IR m=3D3 ,
+.IR \(tijsmith ,
+.I \-v
+and
+.I My\~Document.txt
+are susceptible to misinterpretation by a shell.
+Workarounds typically exist, chiefly via quotation, escape and the explicit
+termination of options processing [see
+.BR sh (1)];
+but when reprocessing of shell-command text requires requotation and
+re-escape, the workarounds become an inconvenient, confusing, error-prone
+hassle.
+.P
+The use of conventional filenames averts the hassle.
+It also makes filenames more recognizable to experienced users.
+.P
+This section introduces broadly observed conventions for filenames.
+.SS The POSIX Portable Filename Character Set
+.P
+In general contexts, especially for international applications,
+conventional filenames are composed using the\~65 ASCII characters of the
+POSIX Portable Filename Character Set.
+The POSIX Portable Filename Character Set consists of the following.
+.TP
+.BR A \- Z
+The\~26 capital or uppercase ASCII letters.
+.TP
+.BR a \- z
+The\~26 small or lowercase ASCII letters.
+.TP
+.BR 0 \- 9
+The ten ASCII digits.
+.TP
+.B . \_ \-
+These three ASCII punctuators:  full stop; low line; hyphen-minus.
+.P
+Special contexts often employ additional characters but, in general
+contexts for international applications, conventional filenames exclude
+characters other than the listed\~65.
+(For noninternational applications, see
+.B LOCALES AND UNICODE
+below.)
+.P
+Observe that the space\~\fB\(aq\0\(aq\fR or\~\fB\eu0020\fR is not listed
+despite being an ASCII character.
+Filenames that include spaces are often encountered for various reasons in
+certain contexts, but such filenames are unconventional in general and are
+inconvenient to use with tools.
+Within filenames, the low line\~\fB\_\fR or hyphen-minus\~\fB\-\fR is
+conventionally employed as necessary instead of the space.
+(See
+.B UNCONVENTIONAL FILENAMES
+and, under
+.B SOFT
+.BR CONVENTIONS ,
+also
+.B Low line versus hyphen-minus
+below.)
+.P
+Incidentally, capital and small letters are distinct within filenames on a
+Linux system; so, for example,
+.I README
+and
+.I readme
+name two different files.
+(Under
+.B SOFT
+.BR CONVENTIONS ,
+see
+.B Capitalization
+below for further observations regarding capitalization.)
+.SS Special semantics
+.P
+Besides the last subsection's POSIX convention, a pair of conventions
+derived from core utilities is almost always respected, as well.
+.TP
+.BR \- name
+A name that begins with a hyphen-minus is conventionally interpreted as a
+command-line option rather than as a filename.
+Therefore, conventional filenames do not begin with the hyphen-minus.
+.TP
+.BR . name
+Conventional filenames may indeed begin with the full stop.
+However, such filenames conventionally designate
+.I hidden files
+(or hidden directories, etc.), a familiar example being the
+.I .profile
+typically found in a user's home directory.
+Hidden files behave normally but, by default, are ignored by
+.BR ls (1)
+and certain other tools.
+.P
+The one-character name\~\fB\-\fR consisting of a lone hyphen-minus is
+sometimes understood by a shell to refer to the previous working directory
+and sometimes understood by tools to refer to standard input or standard
+output, so convention does not employ the lone hyphen-minus as a file's
+proper name.
+The one-character name\~\fB.\fR consisting of a lone full stop has already
+been mentioned under
+.B LEGAL FILENAMES
+above:  one cannot use it as a file's proper name at all.
+.SS The full stop to introduce a format extension
+.P
+Other than at a filename's beginning (a case the last subsection has
+discussed), the full stop is employed in filenames for various further
+conventional purposes.
+No single rule governs all conventional uses of the full stop.
+.P
+However, except at a filename's beginning, the most common conventional use
+of the full stop is to append to a filename's stem an extension to indicate
+the format of the file's contents.
+An example is the filename
+.IR UnicodeData.txt ,
+in which
+.I UnicodeData
+is the stem and the\~\fI.txt\fR indicates that the file contains plain
+text.
+Multiple format extensions are even appended to some filename stems, as in
+.I my-archive.tar.xz
+for instance, which is the name of a tape archive
+.I my-archive.tar
+that, after archival, has subsequently been compressed by
+.BR xz (1).
+.P
+The format-extension convention is all but universally recognized.
+Even nontechnical users are typically familiar with it.
+However, many users employ full stops also for various purposes unrelated
+to format extensions, as well; and they do so often enough that such
+unrelated usage can hardly be called unconventional.
+Except at a filename's beginning, convention supports free use of the full
+stop.
+.P
+.I You
+may reserve the full stop solely to append format extensions if you wish,
+of course.
+Many users do.
+.P
+.\" The next sentence has been corrected according
+.\" to Charles Plessy's helpful
+.\" advice [https://lists.debian.org/debian-devel/2021/08/msg00557.html].
+(If your machine is configured as a desktop or laptop rather than as a
+server, then you can probably find a fairly comprehensive catalog of
+conventional filename extensions, identifying the format each extension
+implies, on your machine in a file such as
+.I /etc/mime.types
+or
+.IR /usr/share/mime/globs .)
+.SH SOFT CONVENTIONS
+.P
+Further filenaming conventions are softer.
+Though often observed, such softer conventions can be bent or broken
+without rendering filenames unconventional.
+.P
+This section introduces soft conventions for filenames.
+.SS Low line versus hyphen-minus
+.P
+Whether to use the low line\~\fB\_\fR or the hyphen-minus\~\fB\-\fR in
+filenames is a matter of preference.
+Except as stated above, convention does not strongly prefer the one over
+the other.
+.P
+If you would like advice, anyway, however, then the kernel's source sets an
+example.
+Most filenames in the kernel's source prefer the hyphen-minus.
+You can do the same if you wish.
+.P
+Even if you prefer the hyphen-minus, though, some exceptions arise, as
+follows.
+.IP \(bu
+The contents of a program's source files usually designate various
+.I entities
+such as variables, functions, types and so forth.
+In\~C and similar programming languages, the hyphen-minus is a minus sign,
+so the designations of entities must use the low line, instead.
+Where a file is named after an entity the file introduces, the filename
+should use low lines as the entity's designation does.
+Examples include the file
+.IR lock\_events.h ,
+which introduces the entity
+.IR lock\_events ,
+in the kernel's source.
+.IP \(bu
+Where distinct separators with different semantics are required, a filename
+can use the low line as an alternate separator.
+Examples include the file
+.IR coreutils\_8.30-3\_amd64.deb ,
+which provides revision\~3 of the Debian binary package that installs
+version\~8.30 of the GNU core utilities for the amd64/x86-64 architecture.
+.IP \(bu
+Occasionally, the name of a file that provides private, internal,
+ephemeral, uninterfaceable or undocumented aspects of an implementation
+will
+.I begin
+with a low line to hint that the file
+.RS
+.IP +
+does not require the user's or programmer's attention or
+.IP +
+is unsuitable for external agents to access directly.
+.RE
+.IP
+Examples include the file
+.\" On the author's PC using Groff's default output device, Groff typesets
+.\" the next line's italicized low line inconsistently compared to the
+.\" manual page's other italicized low lines.  Presumably, Groff does this
+.\" because the low line in question begins its word (though why Groff
+.\" thinks beginning the word significant is unclear), but the
+.\" inconsistency is slightly distracting.
+.I \_sd-common.h
+in systemd's source.
+.IP \(bu
+Sometimes, the low line stands for an unspecified letter of the alphabet.
+.P
+Otherwise, despite that the low line and the hyphen-minus are both
+conventional, if you want advice:  prefer the hyphen-minus.
+.SS Capitalization
+.P
+A loosely observed convention favors small letters in filenames where no
+reason to use capitals exists.
+Many exceptions occur, though, as for example the oft-encountered
+.I Makefile
+that instructs
+.BR make (1)
+how to build an executable program or other autogeneratable file.
+.P
+The reason convention favors small letters is that the general use of small
+letters leaves the capital letters to be employed for emphasis.
+Where the default\~C (or C.UTF-8) locale is in use, the capital ASCII
+letters are collated before all the small ones, whereby
+.BR ls (1)
+lists filenames like
+.I Makefile
+and
+.I README
+before filenames like
+.I a.out
+and
+.IR foo.c .
+[If your locale causes
+.BR ls (1)
+to collate differently when you would have preferred the just-described
+default collation, then try
+.B LC\_ALL=3DC ls
+or
+.B LC\_ALL=3DC.UTF-8 ls
+to suppress the locale.
+See
+.BR locale (7).]
+.P
+Names of types and of certain other entities are sometimes capitalized in
+programming languages like\~C++ and Python.
+Such capitalization can spill over to affect filenames, so it is hard to
+state a general rule.
+.SH LOCALES AND UNICODE
+.\" If another subsection were added to the manual page, then this section
+.\" might be demoted to a subsection and, if appropriate, grouped with the
+.\" new subsection together under a new section
+.\" entitled "FURTHER CONSIDERATIONS."
+.P
+If your application is local rather than international, then you can relax
+POSIX's aforementioned character-set convention at your discretion by
+including graphic Unicode characters; specifically, by including non-ASCII
+Unicode characters for which
+.BR iswgraph (3)
+returns true in your locale or (if your system has it) in the C.UTF-8
+locale.
+[For the relationship between
+.BR unicode (7),
+.BR utf-8 (7)
+and
+.BR ascii (7),
+see the respective manual pages.
+Approximately, in brief, Unicode is a character set, UTF-8 is a
+byte-oriented scheme by which Unicode characters can be encoded, and ASCII
+is both a character set and a byte-oriented scheme that is a subset of both
+Unicode and UTF-8.]
+.P
+To suggest an exact noninternational filenaming rule, other than the
+.BR iswgraph (3)
+rule, for every locale would exceed the scope of this manual page; but
+approximately, in a Japanese or French application for instance, a filename
+might respectively include kanji ideographs or accented Latin letters.
+Filenames that include kanji ideographs or accented Latin letters might be
+hard for international users to read or type, but insofar as such filenames
+exclude spaces, control characters, ASCII symbols (like\~\fB$\fR
+or\~\fB=3D\fR), and ASCII punctuators other than the three punctuators POS=
IX
+recommends, such filenames will not normally cause trouble for tools and,
+thus, may be regarded as conventional within the local context.
+.P
+The use of nonbreaking spaces like\~\fB\eu00A0\fR, \fB\eu2007\fR,
+\fB\eu202F\fR or\~\fB\euFEFF\fR in filenames is probably inadvisable for
+most locales, despite that
+.BR iswgraph (3)
+returns true.
+[The use of ordinary, breaking spaces like\~\fB\eu0020\fR (the familiar
+ASCII space), \fB\eu1680\fR, \fB\eu2000\fR through\~\fB\eu2006\fR,
+\fB\eu2008\fR, \fB\eu2009\fR, \fB\eu200A\fR, \fB\eu205F\fR
+and\~\fB\eu3000\fR is probably also inadvisable, but
+.BR iswgraph (3)
+returns false for those, anyway.]
+.SH UNCONVENTIONAL FILENAMES
+.P
+More than a few files on a typical Linux system, occasionally even
+including standard files employed by and/or automatically installed by an
+operating-system distribution, have unconventional filenames.
+For example, on a Debian GNU/Linux system, some names of files that supply
+software packages use the characters\~\fB+\fR and\~\fB\(ti\fR which, though
+unconventional in general, are normal and expected within that context.
+For another example, in the kernel's source, certain filenames use the
+character\~\fB,\fR to separate a device's designator from the name of the
+device's manufacturer.
+You may have noticed the unconventionally-named
+.I lost+found
+directory lurking at a filesystem's root on your computer; and there are
+further examples, as well.
+.P
+There are many reasons to use unconventional filenames.
+.P
+It is hard to give a general rule, with respect to a particular context, as
+to which unconventional filenames are likely to cause practical troubles
+and which are not.
+If unsure, you can avoid troubles by adhering to convention; but if you
+wish or need to depart from convention, then the only suggestions this
+manual page would make are
+.IP \(bu
+that unconventional filenames not be used without context;
+.IP \(bu
+that unconventional filenames not be used without reason;
+.IP \(bu
+that, even where filenames are unconventional, the recommendations of
+.B Special semantics
+above still be followed if practicable;
+.IP \(bu
+that, where several unconventionally named files are collected, the use of
+unconventional characters be systematic (for example,
+.IR 16:30.log ,
+.IR 16:45.log ,
+.I 17:00.log
+and so on);
+.IP \(bu
+that, even if unconventional symbols or punctuators are employed within
+filenames, one think twice before
+.I beginning
+a filename with an unconventional symbol or punctuator; specifically,
+before beginning a filename with a nonalphanumeric ASCII character other
+than the full stop or low line (consider for example a filename that began
+with the\~\fB\(ti\fR or\~\fB$\fR symbol, which a shell might misinterpret
+as it were a reference to a home directory or shell parameter);
+.IP \(bu
+that, even if non-POSIX characters are used, non-ASCII characters be
+avoided to the extent to which the application is international;
+.IP \(bu
+that the shell's four standard globbing characters\~\fB*?[]\fR be avoided
+in most instances; and
+.IP \(bu
+even if none of the other suggestions is followed, that control characters
+be avoided in any event,
+.I control characters
+being characters, including the tab\~\fB\et\fR and line-feed\~\fB\en\fR
+characters, for which
+.BR iswcntrl (3)
+returns true.
+(Note that, although the use of the space in filenames contravenes POSIX
+and anyway annoys many Linux users, the space is the sole nongraphic ASCII
+character that, by definition, is not a control character.
+Spaces in filenames are unconventional and perhaps inadvisable, but they
+are hardly unusual; whereas tabs and line feeds are, for good reason,
+practically never seen.)
+.SH CONFORMING TO
+.P
+POSIX.1-2008, SUSv4.
+.SH SEE ALSO
+.P
+.BR ls (1),
+.BR sh (1),
+.BR iswcntrl (3),
+.BR iswgraph (3),
+.BR mbrtowc (3),
+.BR wcrtomb (3),
+.BR ext4 (5),
+.BR ascii (7),
+.BR locale (7),
+.BR unicode (7),
+.BR utf-8 (7)
+.P
+info
+.B coreutils
+.\" The author, Thaddeus H. Black, thanks his wife Kristie, daughter Naomi
+.\" and son George for their review and proofreading of various parts of
+.\" this manual page.

--AViBTmudb+KI5xLR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEM1APDU+pwMhnuF4GcGMmQy2FIrwFAmE1/jcACgkQcGMmQy2F
IryJSBAA7gxOabO1LF/mWz2oUtFrSh45AdOuJWT8TDg6iGo/2MSFOOeU4zxPGgSr
t31pEn1gAEl6aqblom6A5fQtQR2DcnKE97CISDwvIOw3lUqFbzWZwUNKBpYbXO1W
FMmejCkBDOHrtceuh53M8lgweUeDrxbVmoz5YkvCwJIpXuTydNsV130fcXevodaR
L57r0hOKfKiJQuAvAY0TZ6v8nztcKtKBLY19JWK+PhiE7FQ5gRZPP6lnxgQSQqgS
zlDI1WppIvP090irfvJJ7T1V+HsjycmdwpGa7i/VTzghmpHp+I5mhWiNMMPzC4lf
3TeG9+VDV6sUlGlPVZJBBia0ja6Atjm9XkRAh7vyT1jojlR4cS4vv3ZkfwxdGq6T
TXkXTGxUaT7Ji5LxWLujTmw2bs6L8qhFX2PIiMBGg8l/f2XJwTZFrd2C3kcwEqiX
7hyk/Kgj9VWpD7os2NyYKibo3E0vC0g/dKYewGgsfmqD7jc90LW8de4Xa9SvfMtm
HHTmZ/p6ooVZV3q8siMu0f4j6YqBFSXDy+ulQPLt2xCmk4Z6BTrE5tGQrX6CW8JL
IhGtNTmsWmtqVE6UiPvGy1DpaKlBt6T3ZRtGPF5glukYScd54JYutoKhPKzPhkEa
E3pWIHEof6tGg2M/H0+WTJLsLWBAn6CseFFOONwpTuSxUTDAEKY=
=9HcA
-----END PGP SIGNATURE-----

--AViBTmudb+KI5xLR--
