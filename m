Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD0BF19C2F4
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Apr 2020 15:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbgDBNr0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Apr 2020 09:47:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58793 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731874AbgDBNr0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Apr 2020 09:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585835245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3kwaJ0d+UkBRg2gpoGbXteHAK8CjxeJ7d/E+V8nL+pU=;
        b=W+4SMDrsJlrBjRIhSLPj4QAxmko87wjBktYoq6qhCRZ0+4CoKQp8hYzihgi1wqdJ6KIvjg
        KhjdstZyPLGrIVzvkHSBsE4ZLyN6+JTL/LIlYJz+n2/spfy2V/SqK2wc0Wv3T6z800TSWh
        XRJnNEjO8bj0zD0AvuOZ2wYSUt+qjx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-CMoZo5WgNIa-iZmcDc-UKA-1; Thu, 02 Apr 2020 09:47:21 -0400
X-MC-Unique: CMoZo5WgNIa-iZmcDc-UKA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F06A10CE7A5;
        Thu,  2 Apr 2020 13:47:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5EBC41001B09;
        Thu,  2 Apr 2020 13:47:19 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Ted Tso <tytso@mit.edu>
Subject: [PATCH] e2scrub: Remove PATH setting from the scripts
Date:   Thu,  2 Apr 2020 15:47:16 +0200
Message-Id: <20200402134716.3725-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We don't want to override system setting by changing the PATH. This
should remain under administrator/user control.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 scrub/e2scrub.in     | 2 --
 scrub/e2scrub_all.in | 2 --
 2 files changed, 4 deletions(-)

diff --git a/scrub/e2scrub.in b/scrub/e2scrub.in
index 30ab7cbd..7c3f46e9 100644
--- a/scrub/e2scrub.in
+++ b/scrub/e2scrub.in
@@ -23,8 +23,6 @@
 # check filesystems in VGs that have at least 256MB (or so) of
 # free space.
=20
-PATH=3D/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
-
 if (( $EUID !=3D 0 )); then
     echo "e2scrub must be run as root"
     exit 1
diff --git a/scrub/e2scrub_all.in b/scrub/e2scrub_all.in
index 4288b969..b6a7d0ad 100644
--- a/scrub/e2scrub_all.in
+++ b/scrub/e2scrub_all.in
@@ -18,8 +18,6 @@
 #  along with this program; if not, write the Free Software Foundation,
 #  Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301, USA.
=20
-PATH=3D/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
-
 if (( $EUID !=3D 0 )); then
     echo "e2scrub_all must be run as root"
     exit 1
--=20
2.21.1

