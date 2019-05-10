Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0254619EE8
	for <lists+linux-ext4@lfdr.de>; Fri, 10 May 2019 16:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfEJOTt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 May 2019 10:19:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbfEJOTt (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 10 May 2019 10:19:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7324330842D1
        for <linux-ext4@vger.kernel.org>; Fri, 10 May 2019 14:19:48 +0000 (UTC)
Received: from [10.43.17.222] (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C6A06013B
        for <linux-ext4@vger.kernel.org>; Fri, 10 May 2019 14:19:47 +0000 (UTC)
To:     linux-ext4@vger.kernel.org
From:   Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH] fix "fsck -A" failure on a completely clean fs
Message-ID: <1462601e-eca2-0270-075b-4738e4cebfed@redhat.com>
Date:   Fri, 10 May 2019 16:19:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------669F565C032A9F28F06416DB"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 10 May 2019 14:19:48 +0000 (UTC)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a multi-part message in MIME format.
--------------669F565C032A9F28F06416DB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Before remounting root fs and mounting local filesystems
in /etc/fstab, my boot scripts check them for errors with:

if ! fsck -A; then
         echo "fsck exit code: $?. Boot will not continue."
         while true; do sleep 9999; done
fi
mount -o remount,rw /
mount -a

Looks like something very straightforward, right?

I have two filesystems in /etc/fstab:
/dev/sda2 /                       ext4    defaults        1 1
/dev/sda1 /boot                   ext4    defaults        1 2

If I use fsck from util-linux-2.33.2-1.fc31.x86_64 (IOW: rather recent code),
it starts two instances of fsck.ext4 (all is fine with it).

The second one's stdio is redirected (probably to /dev/null),
it is no longer the tty. (Which is fine too).

But now we hit a problem. Second fsck.ext4 flat out refuses to do its job,
even before it looks at the filesystem.

Therefore, this condition does not trigger:
         if (getenv("E2FSCK_FORCE_INTERACTIVE") || (isatty(0) && isatty(1))) {
                 ctx->interactive = 1;
         }
and ctx->interactive stays 0.
Therefore, later in main() fsck.ext4 dies with this message:
         if (!(ctx->options & E2F_OPT_PREEN) &&
             !(ctx->options & E2F_OPT_NO) &&
             !(ctx->options & E2F_OPT_YES)) {
                 if (!ctx->interactive)
                         fatal_error(ctx,
                                     _("need terminal for interactive repairs"));
         }

This happens BEFORE any repairs are deemed necessary, IOW: it happens ALWAYS,
even if filesystem is completely fine.

IOW: "fsck -A" is *completely unusable* in this scenario.
I believe this is wrong. It is intended to be the generic, fs-agnostic way
to run fsck's on all /etc/fstab filesystems.

I propose to change the code so that this abort happens only if we
indeed need to interactively ask something.

Tested patch attached.

Fedora BZ: https://bugzilla.redhat.com/show_bug.cgi?id=1702342


--------------669F565C032A9F28F06416DB
Content-Type: text/x-patch;
 name="interactive_bugout.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="interactive_bugout.patch"

diff -uprN e2fsprogs-1.44.4.orig/e2fsck/unix.c e2fsprogs-1.44.4/e2fsck/unix.c
--- e2fsprogs-1.44.4.orig/e2fsck/unix.c	2018-08-19 04:26:58.000000000 +0200
+++ e2fsprogs-1.44.4/e2fsck/unix.c	2019-04-23 15:38:55.890507270 +0200
@@ -1439,13 +1439,6 @@ int main (int argc, char *argv[])
 
 	check_mount(ctx);
 
-	if (!(ctx->options & E2F_OPT_PREEN) &&
-	    !(ctx->options & E2F_OPT_NO) &&
-	    !(ctx->options & E2F_OPT_YES)) {
-		if (!ctx->interactive)
-			fatal_error(ctx,
-				    _("need terminal for interactive repairs"));
-	}
 	ctx->superblock = ctx->use_superblock;
 
 	flags = EXT2_FLAG_SKIP_MMP;
diff -uprN e2fsprogs-1.44.4.orig/e2fsck/util.c e2fsprogs-1.44.4/e2fsck/util.c
--- e2fsprogs-1.44.4.orig/e2fsck/util.c	2018-08-19 04:26:58.000000000 +0200
+++ e2fsprogs-1.44.4/e2fsck/util.c	2019-04-23 15:39:27.571448855 +0200
@@ -203,6 +203,14 @@ int ask_yn(e2fsck_t ctx, const char * st
 	const char	*extra_prompt = "";
 	static int	yes_answers;
 
+	if (!(ctx->options & E2F_OPT_PREEN) &&
+	    !(ctx->options & E2F_OPT_NO) &&
+	    !(ctx->options & E2F_OPT_YES)) {
+		if (!ctx->interactive)
+			fatal_error(ctx,
+				    _("need terminal for interactive repairs"));
+	}
+
 #ifdef HAVE_TERMIOS_H
 	struct termios	termios, tmp;
 

--------------669F565C032A9F28F06416DB--
