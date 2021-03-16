Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC0333CD78
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Mar 2021 06:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbhCPFpo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Mar 2021 01:45:44 -0400
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25577 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhCPFpY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 16 Mar 2021 01:45:24 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Mar 2021 01:45:24 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1615872619; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=aFCdxEhh0cgk1P+euhu53/TQoaW5WY7WA/NHWfsyenK3nTJQhT90aRukGEMN822VGFTfGil3DvpMmLiFWCmbYuf+hGZFukDjRwkrnQlp1jlwqkx3zH5/jcUKlg58yYIFiQeqBSISAcrJKEvO861JqmGVWRiS87875Dlc6E1teNo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1615872619; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=8bDF5hxxqlb6WqQL5Hh1G7oKMRrM3adgFhnultxfnvk=; 
        b=XZWGU/wTdesC9pJ9pOA3bv6vKIIuZyegHKTilJCNe5dgLenqW0QI9MDTEiG5pKoPebIeNPk+oHbdOSNIN0GSu+2lG0a2xxWf2bXZo2KJY0xyFfBcyhfHVVtQCNwDn2T5GZ3smJDtKSxGmqPeApgbojlvH2YRaofJljXV4eo1zeI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=mdjurovic@zohomail.com;
        dmarc=pass header.from=<mdjurovic@zohomail.com> header.from=<mdjurovic@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1615872619;
        s=zm2020; d=zohomail.com; i=mdjurovic@zohomail.com;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=8bDF5hxxqlb6WqQL5Hh1G7oKMRrM3adgFhnultxfnvk=;
        b=m/iNNHQyVzXE+v8iMOylGSnnQ3Ss2G3eNc6yVXwmIhY+f1dY5LS9fwbByGEnxoeB
        rVdaogwn/g84wjPuDYnYLz83W9hASzVeeuPnVCdnVn94oYbUT30SecEexzfBgXJa+1l
        SF3zKGoep/7j0bTaMmF+qtKwJuvXSWfZvxJgEcfY=
Received: from milan-pc.attlocal.net (107-220-151-69.lightspeed.sntcca.sbcglobal.net [107.220.151.69]) by mx.zohomail.com
        with SMTPS id 1615872617652475.3103726985822; Mon, 15 Mar 2021 22:30:17 -0700 (PDT)
From:   Milan Djurovic <mdjurovic@zohomail.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Milan Djurovic <mdjurovic@zohomail.com>
Message-ID: <20210316052953.67616-1-mdjurovic@zohomail.com>
Subject: [PATCH] ext4: dir: Remove unnecessary braces
Date:   Mon, 15 Mar 2021 22:29:53 -0700
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Removes braces to follow the coding style.

Signed-off-by: Milan Djurovic <mdjurovic@zohomail.com>
---
 fs/ext4/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 5ed870614c8d..110688d6b7a6 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -124,9 +124,9 @@ static int ext4_readdir(struct file *file, struct dir_c=
ontext *ctx)
=20
 =09if (is_dx_dir(inode)) {
 =09=09err =3D ext4_dx_readdir(file, ctx);
-=09=09if (err !=3D ERR_BAD_DX_DIR) {
+=09=09if (err !=3D ERR_BAD_DX_DIR)
 =09=09=09return err;
-=09=09}
+
 =09=09/* Can we just clear INDEX flag to ignore htree information? */
 =09=09if (!ext4_has_metadata_csum(sb)) {
 =09=09=09/*
--=20
2.30.1


