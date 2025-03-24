Return-Path: <linux-ext4+bounces-6971-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD477A6E667
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 23:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2195A1894DBC
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 22:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848571EF088;
	Mon, 24 Mar 2025 22:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="UAWpwE8/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334A71EE7BB;
	Mon, 24 Mar 2025 22:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742854238; cv=none; b=lfGYKb1seDj6Sp9Pw53z0RVmECO6UTZexIXCFCuIhuKrMEXZtftCm5oUj6Q+pS3nDvcqHZQ8dGZ6kBNBy4/LBStscWXpCLEZwHoY9m9qLkgqv4YfVxyG11J2bZUDUOhlQKplBzpIOSGWZHUM8b5NSe5aiu4z9hHLZfsbQ4J2dss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742854238; c=relaxed/simple;
	bh=zsWY8qS8zuIETSt8iIrsOojgHvXhoycAQbZSI9tCAuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bcU4IxCF7PvW8KhQ1kDENX2hBWdcmjTxHZBAVPN/P6h4ep3w2lC/kBPAhx8cSFALHCO3O0TbdjeH5lRy9GiJ79rXJiySbTNTwzgZcZsmlkXU/5LJJHdbIwaYIClM5ucwlnE2dIPqe0hF2DJef0SnkK5WeFiBupkUMllKwzNHLLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=UAWpwE8/; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4ZM6gZ6qypzm0R45;
	Mon, 24 Mar 2025 22:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1742854233; x=1745446234; bh=J5mEtuUm0A7K6yocRivKWzDqx8ynCyjDU/P
	eLFthzKc=; b=UAWpwE8/aVYkTkvCti1zIvXCJC9rBnTKyCZtjyHO48hBbtfUmTt
	Ajiu2Np6i51op4W+oEhVGCbOljGxiKFxkL30jtWzUy5aMnWiOf8SdwzZPcFryHir
	QRU5dyGNgvHH1tIkWah8g1reQ1I/TcShttzBq+CmIKtwmJhW97wTutj47a3vtD2n
	OyUazBF1tZp+1+bkURgWDNw1jpdtr0HcY8FdrDONp1QJFChOe6Qp7uZg2YZdjhYX
	hwGb5TEn35sHQd+GnjTGbHX/EORMlr3FPgl0Nv6o7PdbWwt27HNyd2PcVYl9zH/Q
	0hQyerKQxpcv2F05PQBetkyOFX6PQXQfiAA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fHeKHxPkWptN; Mon, 24 Mar 2025 22:10:33 +0000 (UTC)
Received: from localhost.localdomain (dslb-002-206-092-185.002.206.pools.vodafone-ip.de [2.206.92.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: tom.vierjahn@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4ZM6gP0zwmzlfnBq;
	Mon, 24 Mar 2025 22:10:23 +0000 (UTC)
From: Tom Vierjahn <tom.vierjahn@acm.org>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jonathan Corbet <corbet@lwn.net>
Cc: dirk.gouders@w-hs.de,
	Tom Vierjahn <tom.vierjahn@acm.org>,
	linux-ext4@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: ext4: Add fields to ext4_super_block documentation
Date: Mon, 24 Mar 2025 23:09:30 +0100
Message-ID: <20250324221004.5268-1-tom.vierjahn@acm.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Documentation and implementation of the ext4 super block have
slightly diverged: Padding has been removed in order to make room for
new fields that are still missing in the documentation.

Add the new fields s_encryption_level, s_first_error_errorcode,
s_last_error_errorcode to the documentation of the ext4 super block.

Fixes: f542fbe8d5e8 ("ext4 crypto: reserve codepoints used by the ext4 en=
cryption feature")
Fixes: 878520ac45f9 ("ext4: save the error code which triggered an ext4_e=
rror() in the superblock")

Signed-off-by: Tom Vierjahn <tom.vierjahn@acm.org>
---
 Documentation/filesystems/ext4/super.rst | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/ext4/super.rst b/Documentation/fil=
esystems/ext4/super.rst
index a1eb4a11a1d0..1b240661bfa3 100644
--- a/Documentation/filesystems/ext4/super.rst
+++ b/Documentation/filesystems/ext4/super.rst
@@ -328,9 +328,13 @@ The ext4 superblock is laid out as follows in
      - s_checksum_type
      - Metadata checksum algorithm type. The only valid value is 1 (crc3=
2c).
    * - 0x176
-     - __le16
-     - s_reserved_pad
-     -
+     - \_\_u8
+     - s\_encryption\_level
+     - Versioning level for encryption.
+   * - 0x177
+     - \_\_u8
+     - s\_reserved\_pad
+     - Padding to next 32bits.
    * - 0x178
      - __le64
      - s_kbytes_written
@@ -466,9 +470,13 @@ The ext4 superblock is laid out as follows in
      - s_last_error_time_hi
      - Upper 8 bits of the s_last_error_time field.
    * - 0x27A
-     - __u8
-     - s_pad[2]
-     - Zero padding.
+     - \_\_u8
+     - s\_first\_error\_errcode
+     -
+   * - 0x27B
+     - \_\_u8
+     - s\_last\_error\_errcode
+     -
    * - 0x27C
      - __le16
      - s_encoding

base-commit: d5e206778e96e8667d3bde695ad372c296dc9353
--=20
2.49.0


