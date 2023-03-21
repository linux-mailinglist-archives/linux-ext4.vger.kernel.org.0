Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A74B6C2768
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Mar 2023 02:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCUBYK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Mar 2023 21:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCUBYJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Mar 2023 21:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124B211643
        for <linux-ext4@vger.kernel.org>; Mon, 20 Mar 2023 18:23:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61EA261839
        for <linux-ext4@vger.kernel.org>; Tue, 21 Mar 2023 01:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BA1C433EF;
        Tue, 21 Mar 2023 01:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679361817;
        bh=bS3PanxlC580pYtp78985yKC+/NseG/AOhLSKey+0hE=;
        h=Date:From:To:Cc:Subject:From;
        b=dtamlT4RK3YX5ccF+E0X6ZAMZhdm6c7+/3K0ngfq4Zd5xyIxh4/Wo2S9i67HltU0p
         dgIwhaF9IvO1UiPtyxDdHa6/CY2xV+nAGdLA0iO4vKpkvUL7fBYTmRN0hH8H1gzws4
         RtH08shzN+SBDb8HOdpHM1NFPf8QkkPI+rd2eosM4keARoBpdoKrQ/VGUwT2ydSRkR
         vcZfAtL7dMhaguo3lR0tH3p1kjwccunaEiJJfa2mBX4hgzR5w1fjhpckTUv+6WPUE0
         Ibiv9lmJG5tqR75rdh3676RrqqbvEwzD/5scOtEGY/Z8Wb98XaC74cQcVSuALTevUo
         cvGXfp682Op7g==
Date:   Mon, 20 Mar 2023 18:23:37 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ted Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH] e2scrub: fix pathname escaping across all service definitions
Message-ID: <20230321012337.GA11347@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

systemd services provide an "instance name" that can be associated with
a particular invocation of a service.  This allows service users to
invoke multiple copies of a service, each with a unique string.  For
e2scrub, we pass the mountpoint of the filesystem as the instance name.
However, systemd services aren't supposed to have slashes in them, so
we're supposed to escape them.

The canonical escaping scheme for pathnames is defined by the
systemd-escape --path command.  Unfortunately, we've been adding our own
opinionated sauce for years, to work around the fact that --path didn't
quite work right in systemd before January 2017.  The special sauce is
incorrect, and we no longer care about systemd of 7 years past.

Clean up this mess by following the systemd escaping scheme throughout
the service units.  Now we can use the '%f' specifier in them, which
makes things a lot less complicated.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 scrub/e2scrub@.service.in      |    4 ++--
 scrub/e2scrub_all.in           |   20 ++++----------------
 scrub/e2scrub_fail.in          |   10 +++++-----
 scrub/e2scrub_fail@.service.in |    4 ++--
 4 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/scrub/e2scrub@.service.in b/scrub/e2scrub@.service.in
index 496f8948..6425263c 100644
--- a/scrub/e2scrub@.service.in
+++ b/scrub/e2scrub@.service.in
@@ -1,5 +1,5 @@
 [Unit]
-Description=Online ext4 Metadata Check for %I
+Description=Online ext4 Metadata Check for %f
 OnFailure=e2scrub_fail@%i.service
 Documentation=man:e2scrub(8)
 
@@ -16,5 +16,5 @@ User=root
 IOSchedulingClass=idle
 CPUSchedulingPolicy=idle
 Environment=SERVICE_MODE=1
-ExecStart=@root_sbindir@/e2scrub -t %I
+ExecStart=@root_sbindir@/e2scrub -t %f
 SyslogIdentifier=%N
diff --git a/scrub/e2scrub_all.in b/scrub/e2scrub_all.in
index 4288b969..437f6cc2 100644
--- a/scrub/e2scrub_all.in
+++ b/scrub/e2scrub_all.in
@@ -146,22 +146,10 @@ ls_targets() {
 	fi
 }
 
-# systemd doesn't know to do path escaping on the instance variable we pass
-# to the e2scrub service, which breaks things if there is a dash in the path
-# name.  Therefore, do the path escaping ourselves if needed.
-#
-# systemd path escaping also drops the initial slash so we add that back in so
-# that log messages from the service units preserve the full path and users can
-# look up log messages using full paths.  However, for "/" the escaping rules
-# do /not/ drop the initial slash, so we have to special-case that here.
+# Turn our mount path into a service name that systemd will recognize
 escape_path_for_systemd() {
 	local path="$1"
-
-	if [ "${path}" != "/" ]; then
-		echo "-$(systemd-escape --path "${path}")"
-	else
-		echo "-"
-	fi
+	systemd-escape --template 'e2scrub@.service' --path "${path}"
 }
 
 # Scrub any mounted fs on lvm by creating a snapshot and fscking that.
@@ -170,8 +158,8 @@ for tgt in "${targets[@]}"; do
 	# If we're not reaping and systemd is present, try invoking the
 	# systemd service.
 	if [ "${reap}" -ne 1 ] && type systemctl > /dev/null 2>&1; then
-		tgt_esc="$(escape_path_for_systemd "${tgt}")"
-		${DBG} systemctl start "e2scrub@${tgt_esc}" 2> /dev/null
+		svcname="$(escape_path_for_systemd "${tgt}")"
+		${DBG} systemctl start "${svcname}" 2> /dev/null
 		res=$?
 		if [ "${res}" -eq 0 ] || [ "${res}" -eq 1 ]; then
 			continue;
diff --git a/scrub/e2scrub_fail.in b/scrub/e2scrub_fail.in
index 2c0754a9..6899c47c 100644
--- a/scrub/e2scrub_fail.in
+++ b/scrub/e2scrub_fail.in
@@ -2,8 +2,8 @@
 
 # Email logs of failed e2scrub unit runs when the systemd service fails.
 
-device="$1"
-test -z "${device}" && exit 0
+mntpoint="$1"
+test -z "${mntpoint}" && exit 0
 
 if ! type sendmail > /dev/null 2>&1; then
 	echo "$0: sendmail program not found."
@@ -16,7 +16,7 @@ fi
 
 hostname="$(hostname -f 2>/dev/null)"
 test -z "${hostname}" && hostname="${HOSTNAME}"
-service_name="e2scrub@$(systemd-escape ${device})"
+service_name="$(systemd-escape --template "e2scrub@.service" --path "${mntpoint}")"
 
 if test -z "${recipient}" ; then
     recipient="root"
@@ -29,9 +29,9 @@ fi
 (cat << ENDL
 To: ${recipient}
 From: ${sender}
-Subject: e2scrub failure on ${device}
+Subject: e2scrub failure on ${mntpoint}
 
-So sorry, the automatic e2scrub of ${device} on ${hostname} failed.
+So sorry, the automatic e2scrub of ${mntpoint} on ${hostname} failed.
 
 A log of what happened follows:
 ENDL
diff --git a/scrub/e2scrub_fail@.service.in b/scrub/e2scrub_fail@.service.in
index 4bad311b..ae65a1da 100644
--- a/scrub/e2scrub_fail@.service.in
+++ b/scrub/e2scrub_fail@.service.in
@@ -1,10 +1,10 @@
 [Unit]
-Description=Online ext4 Metadata Check Failure Reporting for %I
+Description=Online ext4 Metadata Check Failure Reporting for %f
 Documentation=man:e2scrub(8)
 
 [Service]
 Type=oneshot
-ExecStart=@pkglibdir@/e2scrub_fail "%I"
+ExecStart=@pkglibdir@/e2scrub_fail "%f"
 User=mail
 Group=mail
 SupplementaryGroups=systemd-journal
