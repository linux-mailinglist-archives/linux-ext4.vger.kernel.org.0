Return-Path: <linux-ext4+bounces-472-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D87815405
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 23:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D0528718B
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 22:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883C018EB8;
	Fri, 15 Dec 2023 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nikJ+MMJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1405E18EAC
	for <linux-ext4@vger.kernel.org>; Fri, 15 Dec 2023 22:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025DBC433C8;
	Fri, 15 Dec 2023 22:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702680961;
	bh=k+uPpJzLpKKx1hVjoGFunbkZfAHCmO2yr3wFDvk1IqU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nikJ+MMJVdAC8HD6gHfh2t/JoYaXi5jV4YiRJuoiHsd6BoS71WJTIyRd3zyMhsuW1
	 UfIObZFVgP76Qj2BTrsA16wmxEDjUCBMnWNpPGJXfY7scS936dF6aa6e+2LIREM7oC
	 5WSs6kD+EphKEI2Br5toe9vhfIKxTG7ERSuh0k2mpENnqZjeQ0tyEWhdMH8NizHjAW
	 /UVCkm0m4cNs4ZisjyOYxc+yYjY3XhAnbwjOoADQUFOAIdmA8h2NJ9BMdSAQO9E+38
	 xyUEui3F/xVeUYEYiN+pp22d3ooBiVi5ujxbQ7Yt1KSk9baq0gf0yu4q9Q2y7IFyZT
	 Z5zf9W3QWD8FQ==
Date: Fri, 15 Dec 2023 14:56:00 -0800
Subject: [PATCH 1/2] e2scrub: fix pathname escaping across all service
 definitions
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <170268089755.2679199.17397411719341773099.stgit@frogsfrogsfrogs>
In-Reply-To: <170268089742.2679199.16836622895526209331.stgit@frogsfrogsfrogs>
References: <170268089742.2679199.16836622895526209331.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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


