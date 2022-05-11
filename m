Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC5C5234E9
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 16:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbiEKOB7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 10:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiEKOB7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 10:01:59 -0400
X-Greylist: delayed 159 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 May 2022 07:01:57 PDT
Received: from joooj.vinc17.net (joooj.vinc17.net [155.133.131.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F41D5F8ED
        for <linux-ext4@vger.kernel.org>; Wed, 11 May 2022 07:01:57 -0700 (PDT)
Received: from smtp-zira.vinc17.net (128.119.75.86.rev.sfr.net [86.75.119.128])
        by joooj.vinc17.net (Postfix) with ESMTPSA id 4757F651;
        Wed, 11 May 2022 15:59:17 +0200 (CEST)
Received: by zira.vinc17.org (Postfix, from userid 1000)
        id 21B642800294; Wed, 11 May 2022 15:59:17 +0200 (CEST)
Date:   Wed, 11 May 2022 15:59:17 +0200
From:   Vincent Lefevre <vincent@vinc17.net>
To:     linux-ext4@vger.kernel.org
Subject: ext4: unexpected delayed file creation with a 5.17 kernel
Message-ID: <20220511135917.GA3381602@zira.vinc17.org>
Mail-Followup-To: Vincent Lefevre <vincent@vinc17.net>,
        linux-ext4@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.2.4+14 (d448c911) vl-138565 (2022-05-08)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

On a Linux machine (12-core x86_64 Debian/unstable, 5.17 kernel)
with an ext4 filesystem, I got a file born 30 seconds after its
actual creation by a script. This is completely unreproducible.

Here are the details.

Host/kernel information:

Linux cventin 5.17.0-1-amd64 #1 SMP PREEMPT Debian 5.17.3-1 (2022-04-18) x86_64 GNU/Linux

I started a shell script (which I wrote and have been using for
11 years, but with some evolution since then):

cventin:~> ps -p 667828 -o lstart,cmd
                 STARTED CMD
Tue Apr 26 14:43:15 2022 /bin/sh /home/vlefevre/wd/mpfr/tests/mpfrtests.sh

This script creates a file mpfrtests.cventin.lip.ens-lyon.fr.out
very early. But the first attempts to look at this file failed:

cventin:~/software/mpfr> tail -n 30 mpfrtests.*.out; ll mpfrtests.*.out
zsh: no match
zsh: no match
cventin:~/software/mpfr[1]> tail -n 30 mpfrtests.*.out; ll mpfrtests.*.out
zsh: no match
zsh: no match
cventin:~/software/mpfr[1]> lt|head                                   <14:43:42
total 7016
-rw-r--r--  1  188644 2022-04-26 14:43:42 config.log
-rw-r--r--  1    2861 2022-04-26 14:43:42 conftest.c
-rw-r--r--  1       0 2022-04-26 14:43:42 conftest.err
-rw-r--r--  1    1907 2022-04-26 14:43:42 confdefs.h
-rwxr-xr-x  1  632161 2022-04-26 14:43:16 configure.lineno*
drwxr-xr-x  2    4096 2022-04-26 14:43:11 doc/
drwxr-xr-x  3    4096 2022-04-26 14:43:11 tune/
-rwxr-xr-x  1   23568 2022-04-26 14:43:11 depcomp*
drwxr-xr-x  5   36864 2022-04-26 14:43:11 tests/
cventin:~/software/mpfr> lt|head                                      <14:43:47
total 6416
-rw-r--r--  1   19436 2022-04-26 14:43:47 config.log
-rw-r--r--  1     561 2022-04-26 14:43:47 conftest.c
-rw-r--r--  1       0 2022-04-26 14:43:47 conftest.err
-rw-r--r--  1    4138 2022-04-26 14:43:47 mpfrtests.cfgout
-rw-r--r--  1     500 2022-04-26 14:43:47 confdefs.h
-rwxr-xr-x  1  632161 2022-04-26 14:43:45 configure.lineno*
-rw-r--r--  1     878 2022-04-26 14:43:45 mpfrtests.cventin.lip.ens-lyon.fr.out
drwxr-xr-x  3    4096 2022-04-26 14:43:44 tune/
drwxr-xr-x  4   36864 2022-04-26 14:43:44 tests/

According to /usr/bin/stat, the file birth is

 Birth: 2022-04-26 14:43:45.537241731 +0200

thus 30 seconds after the script started!

Note that the configure.lineno file that appears above is created
*after* mpfrtests.cventin.lip.ens-lyon.fr.out, and one can see
that at 14:43:16, configure.lineno was already created while
mpfrtests.cventin.lip.ens-lyon.fr.out did not appear in the
directory listing.

In the script, the file in question ("$out") is created with

  echo "* $fqdn ($(${1:-.}/config.guess) / ${line#PROC:})" > "$out"

and every other line that writes to the file uses >> "$out"
in order to append data to the file.

In the strace output of the script (obtained by running the
script again), I get

  openat(AT_FDCWD, "….out", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3

corresponding to the > "$out", then

  openat(AT_FDCWD, "….out", O_WRONLY|O_CREAT|O_APPEND, 0666) = 3

corresponding to the >> "$out", and one with

  openat(AT_FDCWD, "….out", O_WRONLY|O_CREAT|O_APPEND, 0666 <unfinished ...>
  <... openat resumed>)  = 3

about 30 seconds later.

Note: concerning the clock of the machine, it is handled by systemd,
and I doubt that there was any "jump"; anyway, even a single jump
would not explain the issue.

FYI, the script is the following one:

  https://gitlab.inria.fr/mpfr/misc/-/blob/fed7770cf5f712871bd116ef80d93ea5885fc3f7/vl-tests/mpfrtests.sh

and the file in question is what appears as "$out".

What I did was running from a MPFR working tree

  /path/to/mpfrtests.sh < /path/to/mpfrtests.data

where the mpfrtests.data file is the following one:

  https://gitlab.inria.fr/mpfr/misc/-/blob/e0204b3423b9bc25c31548d2acc5b8e19a73f48d/vl-tests/mpfrtests.data

Any idea of what could have happened? Is this a known bug?

The fact that the birth occurred 30 seconds late is surprising,
but if I understand correctly, the VFS does not seem to have the
concept of birth time. So perhaps this might explain the behavior,
e.g. if the VFS inode was copied later than expected.

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / AriC project (LIP, ENS-Lyon)
