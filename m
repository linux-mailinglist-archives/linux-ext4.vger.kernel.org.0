Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87458401CE9
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Sep 2021 16:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243185AbhIFOWT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Sep 2021 10:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243062AbhIFOWT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 6 Sep 2021 10:22:19 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F288C061575;
        Mon,  6 Sep 2021 07:21:14 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso5146812wmb.2;
        Mon, 06 Sep 2021 07:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=si7JI2LvAMAOgDxYJX90EJ87iOKyW8hBvIrNITiuNec=;
        b=e5oj8XX7D7VUhg4py16ajABsbMYs5/F7FJA9dsayjkJoe/v0CavcU4+yNWIOm2ojoE
         fNdsgWZ3N0eUeT8U+0Esas0t5zM9QWdl/ycvgMdjHpE0CRRpwlLIm7sah0WxD16YboxN
         etZxIIlQXoM22MxlmJ1dFBUTttk7iPKb2TCtgqq3zxDPjlJgzhIQ7VIg4H18vyCZ3kY8
         yr/DNae303XgNEirOba42V+oqWKrCjUOejALiT5OLTSDjFDwop5uOVhHpHSBtTq4ClxN
         wA6vpcdlkxABWWory1tJLgLYEoy4aIyPATrchqJ0kPW+VVWely9i4Edur+fTKBnnq0x3
         S2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=si7JI2LvAMAOgDxYJX90EJ87iOKyW8hBvIrNITiuNec=;
        b=REYAEFC73VHS/vTWLdb8gQKUBT2v1XOhII4nM9xZB9YxGv+O9lXkSBAw9ReFYKgvcE
         28ev1s/59TwgpHkVBc6mhQDym0nCojxkhpZTvGRNRYuEq1hB5Xk8JQqiqzBC7F4seN+m
         tCyrcO4DmW9Iyn9xcW9MONV8BoXuMJNfCqlxDIGpy0n9we6cxQ0Wilk7/ZtBntyhdKBe
         PRnp3YZwqmYd3SK8jq3PFGm3OOTe95sVajorhhk4EMcLXKqiumFAN57BoFPHGHGODNBN
         +Q6mvRKI3R+wOmIJQiLXoJFv+F+WnsUhbVtwyBsmsDoLnSkJp068w+rc1cbpHOMKptue
         70yg==
X-Gm-Message-State: AOAM531q/S60ZNyajU3ATFZ6EDncTLuJqus/HERbNAg9ZXlKSKi45Zay
        rEx4Io5I5UgDq/pAQ4vp4x0=
X-Google-Smtp-Source: ABdhPJyaiMqMZWSCIpsTMXuQIx2Ds+zhxuIESGhOyAuDxC0wQ449PV4HycuxGMCjD44NzjkYJSN+MQ==
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr7149842wmi.152.1630938072291;
        Mon, 06 Sep 2021 07:21:12 -0700 (PDT)
Received: from [10.8.0.18] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id j20sm8147354wrb.5.2021.09.06.07.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 07:21:11 -0700 (PDT)
Subject: Re: [PATCH] filename.7: new manual page
To:     "Thaddeus H. Black" <thb@debian.org>, linux-man@vger.kernel.org
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        "Dr. Tobias Quathamer" <toddy@debian.org>,
        linux-ext4@vger.kernel.org, debian-doc@lists.debian.org,
        "G. Branden Robinson" <g.branden.robinson@gmail.com>
References: <YTX+PEtj60O/TdMh@b-tk.org>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <a18a8f3d-78a7-15e5-7a6e-0f4740c84667@gmail.com>
Date:   Mon, 6 Sep 2021 16:21:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTX+PEtj60O/TdMh@b-tk.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Thaddeus,

On 9/6/21 1:40 PM, Thaddeus H. Black wrote:
> This email submits to the Linux man-pages project the new manual page
> filename(7).  The manual page's groff source follows in patch format.
> 
> This email is copied to two other, relevant lists as a courtesy, but its
> main target is the list <linux-man@vger.kernel.org>, whose archives are
> at [https://www.spinics.net/lists/linux-man/].
> 
> CONTENTS
> 
> I.   NAME AND BRIEF DESCRIPTION
> II.  HOW INFORMATION TO WRITE THE MANUAL PAGE HAS BEEN OBTAINED
> III. WHY THE MANUAL PAGE HAS BEEN WRITTEN
> IV.  DISTRIBUTIONS AND LOCALES
> V.   GROFF SOURCE (IN PATCH FORMAT)

I *love* this patch!  Even before starting to read it!!  :-}

See some comments below.

Thank you very much!

Alex

[...]
> ---------------------------------------------------------------------------
> II.  HOW INFORMATION TO WRITE THE MANUAL PAGE HAS BEEN OBTAINED
> ---------------------------------------------------------------------------
> 
> The web page [https://www.kernel.org/doc/man-pages/patches.html] asks
> how the information to write the manual page has been obtained.  I have
> obtained the information in eight ways.
> 
> [1] From POSIX.1-2008, SUSv4, sects. 3.281, 3.282 and 4.13.
> Excerpts follow.
> 
> 3.281 Portable Filename
> 
[...]
> The special filename dot shall refer to the directory specified by its
> predecessor.  The special filename dot-dot shall refer to the parent
> directory of its predecessor directory.  As a special case, in the root
> directory, dot-dot may refer to the root directory itself....

I'm surprised that POSIX says _may_ and not _shall_ here.  Is it 
possible that '/..' != '/'?  Or is it just a wording issue of POSIX?

> 
> A pathname consisting of a single <slash> shall resolve to the root
> directory of the process.  A null pathname shall not be
> successfully resolved....
> 
> [2] From the GNU Coreutils manual, ver. 8.32, especially chapter 2 and
> sect. 10.1.1.  Excerpts follow.
> 
> 2 Common options....
> 
> '--' Delimit the option list.  Later arguments, if any, are treated as
> operands even if they begin with '-'.  For example, 'sort -- -r' reads from
> the file named '-r'.
> 
> A single '-' operand is not really an option, though it looks like one.  It
> stands for a file operand, and some tools treat it as standard input, or as
> standard output if that is clear from the context....
> 
> 10.1.1 Which files are listed....
> 
> By default, 'ls' lists files and the contents of any directories on the
> command line, except that in directories it ignores files whose names start
> with '.'.
> 
> [3] From dash(1) and bash(1).
> 
> [4] From the Unicode Standard, ver. 13.0,
> especially Table 4-4. General Category.
> 
> [5] From the Unicode Character Database, which on a Debian GNU/Linux
> system appears at /usr/share/unicode/UnicodeData.txt.  Incidentally, it
> is because of the Unicode Character Database that the manual page calls
> the period a full stop, the slash a solidus, the underscore a low line,
> and the hyphen a hyphen-minus.
> 
> [6] From utf-8(7) and ascii(7).
> 
> [7] From a discussion on the debian-devel mailing list regarding MIME
> types:  [https://lists.debian.org/debian-devel/2021/08/msg00557.html].
> 
> [8] From general experience as a Linux user and, since 2005, as
> a Debian Developer.
> 
> ---------------------------------------------------------------------------
> III. WHY THE MANUAL PAGE HAS BEEN WRITTEN
> ---------------------------------------------------------------------------
> 
> The chief reason the manual page has been written is that newcomers
> to Linux are often advised by experienced users, ad hoc, to avoid
> unconventional filenames like "My Document.txt" in favor of,
> say, "my-document.txt"; only nowhere in basic, conveniently accessible,
> widely installed free documentation is it cogently explained which
> filenames are conventional and, indeed, which are even legal.  Filenames
> being ubiquitous, a proper introduction to them seems due; and anyway
> between ext4(5) and utf-8(7) lies a gap.  Hence the new manual page,
> which fills the gap.

Good.

> 
> ---------------------------------------------------------------------------
> IV.  DISTRIBUTIONS AND LOCALES
> ---------------------------------------------------------------------------
> 
> Since I do not use Arch or Fedora, but only Debian, I would appreciate
> reviews from an Arch user and a Fedora user to ensure that the manual page
> is as correct for those systems as it is for Debian.  The most likely
> point of discrepancy regards MIME types:  see the manual page's
> subsection "The full stop to introduce a format extension."

I can't help here; I use Debian too :).  Michael uses Fedora, I think, 
so maybe he can tell.

> 
> I would also appreciate a review by a native Chinese or Japanese speaker
> of the manual page's section "LOCALES AND UNICODE," if any native Chinese
> or Japanese speaker is reading.  (As far as I know, spaces in
> local Chinese and Japanese filenames are as deprecated as they are, say,
> in local French and German filenames.  However, I don't really know.
> The manual page should not descend into a dissertation regarding every
> possible locale, but I would at least like it to avoid inadvertent false
> statements regarding local filenaming conventions in the
> major Han/Kanji-using languages.)
> 
> ---------------------------------------------------------------------------
> V.   GROFF SOURCE (IN PATCH FORMAT)
> ---------------------------------------------------------------------------
> 
> --- /dev/null	2021-09-06 09:32:09.234024621 +0000
> +++ b/man7/filename.7	2021-09-06 11:16:45.600516972 +0000
> @@ -0,0 +1,519 @@
> +.\" Copyright (C) 2021 Thaddeus H. Black <thb@debian.org>
> +.\"
> +.\" %%%LICENSE_START(VERBATIM)
> +.\" Permission is granted to make and distribute verbatim copies of this
> +.\" manual provided the copyright notice and this permission notice are
> +.\" preserved on all copies.
> +.\"
> +.\" Permission is granted to copy and distribute modified versions of this
> +.\" manual under the conditions for verbatim copying, provided that the
> +.\" entire resulting derived work is distributed under the terms of a
> +.\" permission notice identical to this one.
> +.\"
> +.\" Since the Linux kernel and libraries are constantly changing, this
> +.\" manual page may be incorrect or out-of-date.  The author(s) assume no
> +.\" responsibility for errors or omissions, or for damages resulting from
> +.\" the use of the information contained herein.  The author(s) may not
> +.\" have taken the same level of care in the production of this manual,
> +.\" which is licensed free of charge, as they might when working
> +.\" professionally.
> +.\"
> +.\" Formatted or processed versions of this manual, if unaccompanied by
> +.\" the source, must acknowledge the copyright and authors of this work.
> +.\" %%%LICENSE_END
> +.\"
> +.\" 2021-09-06, Thaddeus H. Black <thb@debian.org>
> +.\"     Wrote the manual page's initial version.
> +.\"
> +.TH FILENAME 7 2021-09-06 "Linux" "Linux Programmer's Manual"
> +.SH NAME
> +.P

I don't know the history of this (actually, I've always wondered why), 
but .PP and .P are equivalent, AFAIK, and we use .PP.

> +filename \- requirements and conventions for the naming of files
> +.SH DESCRIPTION
> +.P
> +This manual page sets forth requirements for and delineates conventions
> +regarding filenames on a Linux system, where a
> +.I filename
> +is either (as the word suggests) the name of a regular file or the name of
> +another object held by the system's filesystem such as a directory,
> +symbolic link, named pipe or device.
> +.SH LEGAL FILENAMES

See man-pages(7):

    Sections within a manual page
        The  list  below  shows conventional or suggested sections.
        Most manual pages should include at least  the  highlighted
        sections.   Arrange  a new manual page so that sections are
        placed in the order shown in the list.

               NAME
               SYNOPSIS
               CONFIGURATION    [Normally only in Section 4]
               DESCRIPTION
               OPTIONS          [Normally only in Sections 1, 8]
               EXIT STATUS      [Normally only in Sections 1, 8]
               RETURN VALUE     [Normally only in Sections 2, 3]
               ERRORS           [Typically only in Sections 2, 3]
               ENVIRONMENT
               FILES
               VERSIONS         [Normally only in Sections 2, 3]

               ATTRIBUTES       [Normally only in Sections 2, 3]
               CONFORMING TO
               NOTES
               BUGS
               EXAMPLES
               AUTHORS          [Discouraged]
               REPORTING BUGS   [Not used in man‐pages]
               COPYRIGHT        [Not used in man‐pages]
               SEE ALSO

        Where a traditional heading would  apply,  please  use  it;
        this kind of consistency can make the information easier to
        understand.  If you must, you can create your own  headings
        if they make things easier to understand (this can be espe‐
        cially useful for pages in Sections 4 and 5).  However, be‐
        fore  doing this, consider whether you could use the tradi‐
        tional headings, with some subsections (.SS)  within  those
        sections.

You could move sections into subsections of DESCRIPTION, and the current 
subsections into tagged paragraphs (.TP).

> +.P
> +A filename on a Linux system can consist of almost any sequence of UTF-8

See man-pages(7):

    Use semantic newlines
        In the source of a manual page,  new  sentences  should  be
        started  on  new  lines, and long sentences should be split
        into lines at clause breaks  (commas,  semicolons,  colons,
        and  so on).  This convention, sometimes known as "semantic
        newlines", makes it easier to see the  effect  of  patches,
        which often operate at the level of individual sentences or
        sentence clauses.


> +characters or, indeed, almost any sequence of bytes.
> +The exceptions are as follows.
> +.SS Reserved characters
> +.TP
> +.B /
> +The solidus is reserved to separate pathname components as for example in
> +.IR /usr/share/doc ,
> +each component being itself a filename.
> +For this reason, no filename may include a solidus.
> +More precisely, no filename may include the byte that, in ASCII and UTF-8,
> +exclusively represents the solidus.
> +.TP
> +.B \e0
> +The null character is reserved for the filesystem to append to terminate a
> +filename's representation in memory.
> +For this reason, no filename may include a null character.
> +More precisely, no filename may include the byte that, in ASCII and UTF-8,
> +exclusively represents the null character.
> +(When appended by the filesystem to terminate a filename's representation
> +in memory, the byte in question is called the
> +.I terminating null
> +.IR byte .
> +Though familiar to\~C programmers, the terminating null byte is usually
> +invisible to users.)
> +.P
> +Note that\~\fB\e0\fR, the null character (or null byte), differs

Please, use a separate line and
.B \e0

We avoid \f.

See man-pages(7) (although it is explained in an unrelated context):

        Any  reference  to  the  subject of the current manual page
        should be written with the name in bold followed by a  pair
        of parentheses in Roman (normal) font.  For example, in the
        fcntl(2) man page, references to the subject  of  the  page
        would  be  written as: fcntl().  The preferred way to write
        this in the source file is:

            .BR fcntl ()

        (Using this format, rather than the  use  of  "\fB...\fP()"
        makes  it  easier to write tools that parse man page source
        files.)


> +from\~\fB0\fR, the printable digit-zero character.

Why did you use the non-breaking space here (and other places)?  I don't 
think it's necessary.

> +The null character (or null byte) is unprintable and registers in ASCII and
> +UTF-8 as the eight-bit pattern\~0x00, whereas the printable digit zero
> +registers as\~0x30 [see the \(lqHex\(rq column in
> +.BR ascii (7)'s
> +character table].
> +Nothing prevents a filename from including a printable digit zero, as for
> +instance the filename
> +.I intel-m10-bmc.h
> +from the kernel's source does.
> +.SS Reserved names
> +.TP
> +.B .
> +The filename consisting of a single full stop is reserved to represent the
> +current directory.
> +.TP
> +.B ..
> +The filename consisting of two full stops is reserved to represent the
> +parent directory.
> +.TP
> +(empty)
> +The empty filename, consisting of no bytes at all (except a terminating
> +null byte), is not allowed.
> +.P
> +The aforementioned current and parent directories are the current
> +.I working
> +directory and its parent except when the\~\fB.\fR or\~\fB..\fR occurs in
> +the middle or at the end of a pathname, in which case the current and
> +parent directories are taken relative to preceding pathname elements.
> +For example, if the current working directory were
> +.IR /home/jsmith ,
> +then
> +.I ../rjones
> +would mean
> +.I /home/rjones
> +but
> +.I foo/bar/../baz
> +would mean
> +.IR /home/jsmith/foo/baz ,
> +whereas
> +.I foo/bar/./baz
> +would mean
> +.IR /home/jsmith/foo/bar/baz .
> +.SS Long names
> +.P
> +No filename may exceed\~255 bytes in length, or\~256 bytes after counting
> +the terminating null byte.
> +.RB ( Reserved
> +.B characters
> +above explains the terminating null byte.)
> +.SS Non-UTF-8 names
> +.P
> +Filenames need not consist of valid UTF-8 characters (although, except
> +where a non-UTF-8 legacy encoding is in use, most filenames do).
> +As long as the requirements of the preceding subsections are met, any
> +sequence of bytes can legally serve as a filename.
> +.SH CONVENTIONAL FILENAMES
> +.P
> +Merely because a filename is legal does not make its use advisable, though.
> +Some legal filenames cause practical troubles.
> +For example, the legal filenames
> +.IR m=3 ,
> +.IR \(tijsmith ,
> +.I \-v
> +and
> +.I My\~Document.txt
> +are susceptible to misinterpretation by a shell.
> +Workarounds typically exist, chiefly via quotation, escape and the explicit
> +termination of options processing [see
> +.BR sh (1)];

I'd have used parentheses there. No?  Was it, as in Mathematics, to 
clearly differentiate the inner from the outer parentheses?  If so, we 
typically nest parentheses in the manual pages (as in here (see?)).

However, I don't think it's wrong per se to use brackets...  Is it 
common in other places?  Maybe the add some readability to the text, and 
we hould use them.

> +but when reprocessing of shell-command text requires requotation and
> +re-escape, the workarounds become an inconvenient, confusing, error-prone
> +hassle.
> +.P
> +The use of conventional filenames averts the hassle.
> +It also makes filenames more recognizable to experienced users.
> +.P
> +This section introduces broadly observed conventions for filenames.
> +.SS The POSIX Portable Filename Character Set
> +.P
> +In general contexts, especially for international applications,
> +conventional filenames are composed using the\~65 ASCII characters of the
> +POSIX Portable Filename Character Set.
> +The POSIX Portable Filename Character Set consists of the following.
> +.TP
> +.BR A \- Z
> +The\~26 capital or uppercase ASCII letters.
> +.TP
> +.BR a \- z
> +The\~26 small or lowercase ASCII letters.
> +.TP
> +.BR 0 \- 9
> +The ten ASCII digits.
> +.TP
> +.B . \_ \-
> +These three ASCII punctuators:  full stop; low line; hyphen-minus.
> +.P
> +Special contexts often employ additional characters but, in general
> +contexts for international applications, conventional filenames exclude
> +characters other than the listed\~65.
> +(For noninternational applications, see
> +.B LOCALES AND UNICODE
> +below.)
> +.P
> +Observe that the space\~\fB\(aq\0\(aq\fR or\~\fB\eu0020\fR is not listed
> +despite being an ASCII character.
> +Filenames that include spaces are often encountered for various reasons in
> +certain contexts, but such filenames are unconventional in general and are
> +inconvenient to use with tools.
> +Within filenames, the low line\~\fB\_\fR or hyphen-minus\~\fB\-\fR is
> +conventionally employed as necessary instead of the space.
> +(See
> +.B UNCONVENTIONAL FILENAMES
> +and, under
> +.B SOFT
> +.BR CONVENTIONS ,
> +also
> +.B Low line versus hyphen-minus
> +below.)
> +.P
> +Incidentally, capital and small letters are distinct within filenames on a
> +Linux system; so, for example,
> +.I README
> +and
> +.I readme
> +name two different files.
> +(Under
> +.B SOFT
> +.BR CONVENTIONS ,
> +see
> +.B Capitalization > +below for further observations regarding capitalization.)

Maybe a mention to filesystems is warranted here.
FAT on Linux is still case-insensitive, right?

> +.SS Special semantics
> +.P
> +Besides the last subsection's POSIX convention, a pair of conventions

s/a pair of/some/

The third one being '-'.

> +derived from core utilities is almost always respected, as well.
> +.TP
> +.BR \- name
> +A name that begins with a hyphen-minus is conventionally interpreted as a
> +command-line option rather than as a filename.
> +Therefore, conventional filenames do not begin with the hyphen-minus.
> +.TP
> +.BR . name
> +Conventional filenames may indeed begin with the full stop.
> +However, such filenames conventionally designate
> +.I hidden files
> +(or hidden directories, etc.), a familiar example being the
> +.I .profile
> +typically found in a user's home directory.
> +Hidden files behave normally but, by default, are ignored by
> +.BR ls (1)
> +and certain other tools.
> +.P

I'd also add here (for consistency):

.TP
.B \-

> +The one-character name\~\fB\-\fR consisting of a lone hyphen-minus is
> +sometimes understood by a shell to refer to the previous working directory
> +and sometimes understood by tools to refer to standard input or standard
> +output, so convention does not employ the lone hyphen-minus as a file's
> +proper name.

> +The one-character name\~\fB.\fR consisting of a lone full stop has already
> +been mentioned under

Why talk about '.' here but not '..'?

Anyway, '.' is not a convention but a reserved name, so I think it 
shouldn't be mentioned here.

> +.B LEGAL FILENAMES
> +above:  one cannot use it as a file's proper name at all.
> +.SS The full stop to introduce a format extension
> +.P
> +Other than at a filename's beginning (a case the last subsection has
> +discussed), the full stop is employed in filenames for various further
> +conventional purposes.
> +No single rule governs all conventional uses of the full stop.
> +.P
> +However, except at a filename's beginning, the most common conventional use
> +of the full stop is to append to a filename's stem an extension to indicate
> +the format of the file's contents.
> +An example is the filename
> +.IR UnicodeData.txt ,
> +in which
> +.I UnicodeData
> +is the stem and the\~\fI.txt\fR indicates that the file contains plain
> +text.
> +Multiple format extensions are even appended to some filename stems, as in
> +.I my-archive.tar.xz
> +for instance, which is the name of a tape archive
> +.I my-archive.tar
> +that, after archival, has subsequently been compressed by
> +.BR xz (1).
> +.P
> +The format-extension convention is all but universally recognized.

Non-native English speakers may have trouble understanding "all but". 
Maybe s/all but/not/?

> +Even nontechnical users are typically familiar with it.
> +However, many users employ full stops also for various purposes unrelated
> +to format extensions, as well; and they do so often enough that such
> +unrelated usage can hardly be called unconventional.
> +Except at a filename's beginning, convention supports free use of the full
> +stop.
> +.P
> +.I You
> +may reserve the full stop solely to append format extensions if you wish,
> +of course.
> +Many users do.
> +.P
> +.\" The next sentence has been corrected according
> +.\" to Charles Plessy's helpful
> +.\" advice [https://lists.debian.org/debian-devel/2021/08/msg00557.html].
> +(If your machine is configured as a desktop or laptop rather than as a
> +server, then you can probably find a fairly comprehensive catalog of
> +conventional filename extensions, identifying the format each extension
> +implies, on your machine in a file such as
> +.I /etc/mime.types
> +or
> +.IR /usr/share/mime/globs .)
> +.SH SOFT CONVENTIONS
> +.P
> +Further filenaming conventions are softer.
> +Though often observed, such softer conventions can be bent or broken
> +without rendering filenames unconventional.
> +.P
> +This section introduces soft conventions for filenames.
> +.SS Low line versus hyphen-minus
> +.P
> +Whether to use the low line\~\fB\_\fR or the hyphen-minus\~\fB\-\fR in
> +filenames is a matter of preference.
> +Except as stated above, convention does not strongly prefer the one over
> +the other.
> +.P
> +If you would like advice, anyway, however, then the kernel's source sets an
> +example.
> +Most filenames in the kernel's source prefer the hyphen-minus.
> +You can do the same if you wish.
> +.P
> +Even if you prefer the hyphen-minus, though, some exceptions arise, as
> +follows.
> +.IP \(bu
> +The contents of a program's source files usually designate various
> +.I entities
> +such as variables, functions, types and so forth.
> +In\~C and similar programming languages, the hyphen-minus is a minus sign,
> +so the designations of entities must use the low line, instead.
> +Where a file is named after an entity the file introduces, the filename
> +should use low lines as the entity's designation does.
> +Examples include the file
> +.IR lock\_events.h ,
> +which introduces the entity
> +.IR lock\_events ,
> +in the kernel's source.
> +.IP \(bu
> +Where distinct separators with different semantics are required, a filename
> +can use the low line as an alternate separator.
> +Examples include the file
> +.IR coreutils\_8.30-3\_amd64.deb ,
> +which provides revision\~3 of the Debian binary package that installs
> +version\~8.30 of the GNU core utilities for the amd64/x86-64 architecture.
> +.IP \(bu
> +Occasionally, the name of a file that provides private, internal,
> +ephemeral, uninterfaceable or undocumented aspects of an implementation
> +will
> +.I begin
> +with a low line to hint that the file
> +.RS
> +.IP +
> +does not require the user's or programmer's attention or
> +.IP +
> +is unsuitable for external agents to access directly.
> +.RE
> +.IP
> +Examples include the file
> +.\" On the author's PC using Groff's default output device, Groff typesets
> +.\" the next line's italicized low line inconsistently compared to the
> +.\" manual page's other italicized low lines.  Presumably, Groff does this
> +.\" because the low line in question begins its word (though why Groff
> +.\" thinks beginning the word significant is unclear), but the
> +.\" inconsistency is slightly distracting.
> +.I \_sd-common.h
> +in systemd's source.
> +.IP \(bu
> +Sometimes, the low line stands for an unspecified letter of the alphabet.
> +.P
> +Otherwise, despite that the low line and the hyphen-minus are both
> +conventional, if you want advice:  prefer the hyphen-minus.
> +.SS Capitalization
> +.P
> +A loosely observed convention favors small letters in filenames where no
> +reason to use capitals exists.

Most manual pages talking about capitalization typically use the term 
'case' (uppercase, lowercase, case sensitive, ...); probably because of 
'toupper()' and 'tolower()'.  I think, for consistency, using the same 
terminology would be better.

Or is it Unicode terminology you were using?

> +Many exceptions occur, though, as for example the oft-encountered
> +.I Makefile
> +that instructs
> +.BR make (1)
> +how to build an executable program or other autogeneratable file.
> +.P
> +The reason convention favors small letters is that the general use of small
> +letters leaves the capital letters to be employed for emphasis.
> +Where the default\~C (or C.UTF-8) locale is in use, the capital ASCII
> +letters are collated before all the small ones, whereby
> +.BR ls (1)
> +lists filenames like
> +.I Makefile
> +and
> +.I README
> +before filenames like
> +.I a.out
> +and
> +.IR foo.c .
> +[If your locale causes
> +.BR ls (1)
> +to collate differently when you would have preferred the just-described
> +default collation, then try
> +.B LC\_ALL=C ls
> +or
> +.B LC\_ALL=C.UTF-8 ls
> +to suppress the locale.
> +See
> +.BR locale (7).]
> +.P
> +Names of types and of certain other entities are sometimes capitalized in
> +programming languages like\~C++ and Python.

Do you mean normal user conventions?  I mean, the standard C++ library 
(and the language) doesn't use uppercase, AFAIR.  Not even in the cases 
where C used it (e.g., _Bool)

> +Such capitalization can spill over to affect filenames, so it is hard to
> +state a general rule.
> +.SH LOCALES AND UNICODE
> +.\" If another subsection were added to the manual page, then this section
> +.\" might be demoted to a subsection and, if appropriate, grouped with the
> +.\" new subsection together under a new section
> +.\" entitled "FURTHER CONSIDERATIONS."
> +.P
> +If your application is local rather than international, then you can relax
> +POSIX's aforementioned character-set convention at your discretion by
> +including graphic Unicode characters; specifically, by including non-ASCII
> +Unicode characters for which
> +.BR iswgraph (3)
> +returns true in your locale or (if your system has it) in the C.UTF-8
> +locale.
> +[For the relationship between
> +.BR unicode (7),
> +.BR utf-8 (7)
> +and
> +.BR ascii (7),
> +see the respective manual pages.
> +Approximately, in brief, Unicode is a character set, UTF-8 is a
> +byte-oriented scheme by which Unicode characters can be encoded, and ASCII
> +is both a character set and a byte-oriented scheme that is a subset of both
> +Unicode and UTF-8.]
> +.P
> +To suggest an exact noninternational filenaming rule, other than the
> +.BR iswgraph (3)
> +rule, for every locale would exceed the scope of this manual page; but
> +approximately, in a Japanese or French application for instance, a filename
> +might respectively include kanji ideographs or accented Latin letters.
> +Filenames that include kanji ideographs or accented Latin letters might be
> +hard for international users to read or type, but insofar as such filenames
> +exclude spaces, control characters, ASCII symbols (like\~\fB$\fR
> +or\~\fB=\fR), and ASCII punctuators other than the three punctuators POSIX
> +recommends, such filenames will not normally cause trouble for tools and,
> +thus, may be regarded as conventional within the local context.
> +.P
> +The use of nonbreaking spaces like\~\fB\eu00A0\fR, \fB\eu2007\fR,
> +\fB\eu202F\fR or\~\fB\euFEFF\fR in filenames is probably inadvisable for
> +most locales, despite that
> +.BR iswgraph (3)
> +returns true.
> +[The use of ordinary, breaking spaces like\~\fB\eu0020\fR (the familiar
> +ASCII space), \fB\eu1680\fR, \fB\eu2000\fR through\~\fB\eu2006\fR,
> +\fB\eu2008\fR, \fB\eu2009\fR, \fB\eu200A\fR, \fB\eu205F\fR
> +and\~\fB\eu3000\fR is probably also inadvisable, but
> +.BR iswgraph (3)
> +returns false for those, anyway.]
> +.SH UNCONVENTIONAL FILENAMES
> +.P
> +More than a few files on a typical Linux system, occasionally even
> +including standard files employed by and/or automatically installed by an
> +operating-system distribution, have unconventional filenames.
> +For example, on a Debian GNU/Linux system, some names of files that supply
> +software packages use the characters\~\fB+\fR and\~\fB\(ti\fR which, though
> +unconventional in general, are normal and expected within that context.
> +For another example, in the kernel's source, certain filenames use the
> +character\~\fB,\fR to separate a device's designator from the name of the
> +device's manufacturer.
> +You may have noticed the unconventionally-named
> +.I lost+found
> +directory lurking at a filesystem's root on your computer; and there are
> +further examples, as well.
> +.P
> +There are many reasons to use unconventional filenames.
> +.P
> +It is hard to give a general rule, with respect to a particular context, as
> +to which unconventional filenames are likely to cause practical troubles
> +and which are not.
> +If unsure, you can avoid troubles by adhering to convention; but if you
> +wish or need to depart from convention, then the only suggestions this
> +manual page would make are
> +.IP \(bu
> +that unconventional filenames not be used without context;
> +.IP \(bu
> +that unconventional filenames not be used without reason;
> +.IP \(bu
> +that, even where filenames are unconventional, the recommendations of
> +.B Special semantics
> +above still be followed if practicable;
> +.IP \(bu
> +that, where several unconventionally named files are collected, the use of
> +unconventional characters be systematic (for example,
> +.IR 16:30.log ,
> +.IR 16:45.log ,
> +.I 17:00.log
> +and so on);
> +.IP \(bu
> +that, even if unconventional symbols or punctuators are employed within
> +filenames, one think twice before
> +.I beginning
> +a filename with an unconventional symbol or punctuator; specifically,
> +before beginning a filename with a nonalphanumeric ASCII character other
> +than the full stop or low line (consider for example a filename that began
> +with the\~\fB\(ti\fR or\~\fB$\fR symbol, which a shell might misinterpret
> +as it were a reference to a home directory or shell parameter);
> +.IP \(bu
> +that, even if non-POSIX characters are used, non-ASCII characters be
> +avoided to the extent to which the application is international;
> +.IP \(bu
> +that the shell's four standard globbing characters\~\fB*?[]\fR be avoided
> +in most instances; and
> +.IP \(bu
> +even if none of the other suggestions is followed, that control characters
> +be avoided in any event,
> +.I control characters
> +being characters, including the tab\~\fB\et\fR and line-feed\~\fB\en\fR
> +characters, for which
> +.BR iswcntrl (3)
> +returns true.
> +(Note that, although the use of the space in filenames contravenes POSIX
> +and anyway annoys many Linux users, the space is the sole nongraphic ASCII
> +character that, by definition, is not a control character.
> +Spaces in filenames are unconventional and perhaps inadvisable, but they
> +are hardly unusual; whereas tabs and line feeds are, for good reason,
> +practically never seen.)
> +.SH CONFORMING TO
> +.P
> +POSIX.1-2008, SUSv4.
The SUSv4 part of the standard is the same that is in POSIX.1-2008?  Or 
does it have any extensions regarding filenames that isn't in POSIX?

If both standards have the same exact contents about filenames, I'd 
simplify this with POSIX.1-2008 only.

> +.SH SEE ALSO
> +.P
> +.BR ls (1),
> +.BR sh (1),
> +.BR iswcntrl (3),
> +.BR iswgraph (3),
> +.BR mbrtowc (3),
> +.BR wcrtomb (3),
> +.BR ext4 (5),
> +.BR ascii (7),
> +.BR locale (7),
> +.BR unicode (7),
> +.BR utf-8 (7)

maybe filesystems(7)?

> +.P
> +info
> +.B coreutils
> +.\" The author, Thaddeus H. Black, thanks his wife Kristie, daughter Naomi
> +.\" and son George for their review and proofreading of various parts of
> +.\" this manual page.
> 


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
