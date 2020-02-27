Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 785AC1722AA
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Feb 2020 16:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgB0P5v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Feb 2020 10:57:51 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45432 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbgB0P5v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Feb 2020 10:57:51 -0500
Received: by mail-lj1-f193.google.com with SMTP id e18so3991881ljn.12
        for <linux-ext4@vger.kernel.org>; Thu, 27 Feb 2020 07:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NkL7VeqypyFgdYwjZgulexD9PO6GFjbMBuocMMKsf5g=;
        b=hRaMHJ7Zv2rEGxzRaR57wQI6Kew+xHLdqXHeXrzHLDMrxlRjWITKgvFuvbvJNOx+bD
         2RIS8CCO4nv6ZEeFHKA6SjYw3+rDqSq/ISG9/7H827pSDwqw7Z6WJrRwtyLsl5YsI22t
         +Q2fIl1rMSkH4iaPM+gZ7ULb2k1UaHjdZx3Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NkL7VeqypyFgdYwjZgulexD9PO6GFjbMBuocMMKsf5g=;
        b=A4sFS2njMeOHOk7d5ut7/nW8I9HJEapDexB9PGU5EZ6IKQ+QJNMXH9rv7Ef5xntSld
         Gs29ubbzV0lTE9WfIF1Zy6d47hczDQ3mVljeUxL+GFNbtcntg7UDyMClOJk0/EXlX1LU
         1++zh+LZsC13/g8IJpUdrYjRnJceDHLHrQ8UZTq3e7jwpNO0NWCZK3k3OwYd+T4J8VCL
         peBSQWcd5YQQkB6ejFRa+dBWuyZSdGZtVWhOQATWI6tiKU325mY6kTlaR28lSWp8NATF
         lrpWo1vPHkeuzrEhb7VZg+U7lbcffAewH32/NO13HYe0eVlIE/7hzKhlH87Ng1JfG+Hj
         Iz7w==
X-Gm-Message-State: ANhLgQ1QTQ8MwFP1k86ZWGZaKqBtqJbWAFKrLktkZo1HocmG61QvzmrF
        njmzRz9FaUwaZ0RxZlwY6EJIuPjJlOthcA==
X-Google-Smtp-Source: ADFU+vubWYjqh9wU+NJpx6fwbmxKGd21f55JaOejbX3tyRSiM5CMVmGsY3GAKkxZSKeoaZSlQNxnDA==
X-Received: by 2002:a2e:b177:: with SMTP id a23mr109231ljm.202.1582819068063;
        Thu, 27 Feb 2020 07:57:48 -0800 (PST)
Received: from [192.168.1.149] (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id v12sm3488991ljc.94.2020.02.27.07.57.46
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 07:57:47 -0800 (PST)
Subject: Re: vmlinux ELF header sometimes corrupt
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-ext4@vger.kernel.org
References: <71aa76d0-a3b8-b4f3-a7c3-766cfb75412f@rasmusvillemoes.dk>
 <5997e9b6-95fd-405b-05f8-16f9e34d9d87@rasmusvillemoes.dk>
Message-ID: <70be00f8-1559-b74d-c9cf-2e5423f625d4@rasmusvillemoes.dk>
Date:   Thu, 27 Feb 2020 16:57:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5997e9b6-95fd-405b-05f8-16f9e34d9d87@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 28/01/2020 09.12, Rasmus Villemoes wrote:

> I've done a long overdue kernel update, and there are quite a few
> fs/ext4/ -stable patches in there, so now I'll see if it still happens.

OK, I still see the vmlinux corruption.

To recap: My laptop uses a Ubuntu 4.15 kernel. I'm building a ppc32 kernel

export ARCH=powerpc
export CROSS_COMPILE=powerpc-linux-gnu-
make 83xx/mpc8315_rdb_defconfig
make -j8

Then "file vmlinux" says all is good: "ELF 32-bit MSB executable,
PowerPC or ..."

Time passes, I/O in other parts of the system etc., now suddenly "file
vmlinux" says "data". Inspecting the file shows that the first 52 bytes
(aka exactly the ELF header) are 0. Instrumenting the kernel build [1]
to save some intermediate stages tells me that the vmlinux file is fine
beyond 52 bytes. I.e.,

$ cmp -i 52 vmlinux vmlinux.after_sort

is fine. Now comparing stat(1) on vmlinux immediately after sortextable
to stat(1) on the corrupted vmlinux shows something a bit odd in the
Blocks: field, but ino, mtime are unchanged (as one would expect when
nothing should have touched that file).

$ cat vmlinux.stat.after_sort
  File: vmlinux
  Size: 8055408         Blocks: 15624      IO Block: 4096   regular file
Device: 811h/2065d      Inode: 85736362    Links: 1
Access: (0775/-rwxrwxr-x)  Uid: ( 1000/    ravi)   Gid: ( 1000/    ravi)
Access: 2020-02-27 13:15:10.989950361 +0100
Modify: 2020-02-27 13:15:11.033950470 +0100
Change: 2020-02-27 13:15:11.033950470 +0100
 Birth: -

$ stat vmlinux
  File: vmlinux
  Size: 8055408         Blocks: 15616      IO Block: 4096   regular file
Device: 811h/2065d      Inode: 85736362    Links: 1
Access: (0775/-rwxrwxr-x)  Uid: ( 1000/    ravi)   Gid: ( 1000/    ravi)
Access: 2020-02-27 15:46:55.354409876 +0100
Modify: 2020-02-27 13:15:11.033950470 +0100
Change: 2020-02-27 13:15:11.033950470 +0100
 Birth: -

Oddly enough, I never seem to have problems with any other files, so I'm
thinking there's some particular I/O pattern involved when ld creates
the vmlinux file. It does

lseek(6, 0, SEEK_SET)                   = 0
read(6, "", 52)                         = 0
lseek(6, 52, SEEK_CUR)                  = 52

initially, and then much later actually writes the header

lseek(6, 0, SEEK_SET)                   = 0
write(6,
"\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\2\0\24\0\0\0\1\300\0\0\0\0\0\0004"...,
52) = 52

Then sortextable does some poking around, but that's just via mmap(), so
not much to see in strace.

I also don't seem to be able to reproduce it when I build an x86_64
kernel instead of ppc32 - perhaps the bigger ELF header matters? I'll
try some other 32 bit platforms.

I have tried creating an ext4 image in a 50 GB file with the exact same
file system options [2] and did a "make O=..." build to see if I could
make an image file containing the corrupted state, but so far no luck.
fsck on /dev/sdb1 says my filesystem is just fine.

This is starting to drive me a bit crazy, so I really hope someone goes
"yeah, you should run at least v5.2, that has commit abc123def which
fixes that".

Thanks,
Rasmus

[1] I've applied this on top of v4.19.82:
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index c8cf45362bd6..6a6d8ac79607 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -94,8 +94,13 @@ vmlinux_link()
                        ${KBUILD_VMLINUX_LIBS}                  \
                        --end-group                             \
                        ${1}"
+                if [ "${2}" = vmlinux ] ; then
+                    strace="strace -o ${objtree}/vmlinux.strace"
+                else
+                    strace=""
+                fi

-               ${LD} ${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux} -o ${2}      \
+               $strace ${LD} ${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux} -o
${2}      \
                        -T ${lds} ${objects}
        else
                objects="-Wl,--whole-archive                    \
@@ -151,7 +156,7 @@ mksysmap()

 sortextable()
 {
-       ${objtree}/scripts/sortextable ${1}
+       strace -o ${objtree}/sortextable.strace
${objtree}/scripts/sortextable ${1}
 }

 # Delete output files in case of error
@@ -283,7 +288,13 @@ vmlinux_link "${kallsymso}" vmlinux

 if [ -n "${CONFIG_BUILDTIME_EXTABLE_SORT}" ]; then
        info SORTEX vmlinux
+       stat vmlinux > vmlinux.stat.before_sort
+       cp --preserve=all vmlinux vmlinux.before_sort
+       file vmlinux >&2
        sortextable vmlinux
+       stat vmlinux > vmlinux.stat.after_sort
+       cp --preserve=all vmlinux vmlinux.after_sort
+       file vmlinux >&2
 fi

 info SYSMAP System.map

[2] $ sudo dumpe2fs -h /dev/sdb1
[sudo] password for ravi:
dumpe2fs 1.44.1 (24-Mar-2018)
Filesystem volume name:   <none>
Last mounted on:          /mnt/ext4
Filesystem UUID:          2b70b7ba-fdd7-4616-8431-2b04ea31d803
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr dir_index filetype
needs_recovery extent 64bit flex_bg metadata_csum_seed inline_data
sparse_super large_file extra_isize metadata_csum
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              117440512
Block count:              469762048
Reserved block count:     23488102
Free blocks:              223934526
Free inodes:              88111686
First block:              0
Block size:               4096
Fragment size:            4096
Group descriptor size:    64
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         8192
Inode blocks per group:   1024
Flex block group size:    16
Filesystem created:       Thu Jun 13 08:04:11 2019
Last mount time:          Wed Jan 29 21:01:18 2020
Last write time:          Wed Jan 29 21:01:18 2020
Mount count:              1
Maximum mount count:      -1
Last checked:             Wed Jan 29 20:49:04 2020
Check interval:           0 (<none>)
Lifetime writes:          1563 GB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               512
Required extra isize:     32
Desired extra isize:      32
Journal inode:            8
First orphan inode:       87165617
Default directory hash:   half_md4
Directory Hash Seed:      d1ac8c45-70f3-4e6e-9710-b7e434bb59ba
Journal backup:           inode blocks
Checksum type:            crc32c
Checksum:                 0x950a844d
Checksum seed:            0x143063d3
Journal features:         journal_incompat_revoke journal_64bit
journal_checksum_v3
Journal size:             1024M
Journal length:           262144
Journal sequence:         0x0003218a
Journal start:            219662
Journal checksum type:    crc32c
Journal checksum:         0xea20aea2
