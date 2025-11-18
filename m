Return-Path: <linux-ext4+bounces-11899-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D7CC695D0
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Nov 2025 13:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E3064E43CD
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Nov 2025 12:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465CE354AD7;
	Tue, 18 Nov 2025 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="ZFsTHmyB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88D734EF1F
	for <linux-ext4@vger.kernel.org>; Tue, 18 Nov 2025 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763468743; cv=none; b=BMixKwki/WKgj3el6gK3hXeTewkRT/CYVNsYMI3Y4FA0AzE/xtG2h3QlaOfO2VFy0khrh4DWu1lshVe61uS0k3gMWsc6ghgWtefY/RUsfqZLEMBdIRS807JId12Xpr0imj9M2cnUUQnDoWlPeGOb9Bsc4ijckpjExCZsvSSPlvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763468743; c=relaxed/simple;
	bh=if2lTJRHYknk2V7u1+qek4SpiUP1h6XPP8zeJ2fBkB8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmUDqjlTebJYbgWveJCyo6yfZebOPkDBUnmCeNCQt3du0FEa3qRGjTaeI1m6agzINwfc//AUwvT9E+xSE9Rag2pLwI2y2ZYo29cmFYcTjidhbHi6tvE3XDvrNei5oCqj0hIzI53uPbZZr93ebXM5jijpEyu+Ab9dtJABkWQR5kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=ZFsTHmyB; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lKJj2CKlWazKdapyGoiY+2FkpDyPj8ibaVZeWWa4Ddk=;
	b=ZFsTHmyBTZZMEbex+jPp6O53HF3MN4NzZKm3FvYTAnqZoGEqXjrXDZzwbwO0Efv4kQTf/SLz4
	l0ur80xUbvOfMmfxxybi53s8Mk9gAQEERLbW+j+bXCGNXAQY8hPBJ0jkqxG7TDZi+ffuNXF6+GE
	pch+JPOzxdXgPZ7LHealZBg=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4d9kLP28jjz1K9BS;
	Tue, 18 Nov 2025 20:23:57 +0800 (CST)
Received: from kwepemj500016.china.huawei.com (unknown [7.202.194.46])
	by mail.maildlp.com (Postfix) with ESMTPS id D9355180042;
	Tue, 18 Nov 2025 20:25:38 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemj500016.china.huawei.com
 (7.202.194.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 18 Nov
 2025 20:25:38 +0800
From: Wu Guanghao <wuguanghao3@huawei.com>
To: <tytso@mit.edu>
CC: <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<yangyun50@huawei.com>, <wuguanghao3@huawei.com>
Subject: [PATCH 2/2] resize: fix memory leak when exiting normally
Date: Tue, 18 Nov 2025 21:26:01 +0800
Message-ID: <20251118132601.2756185-3-wuguanghao3@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20251118132601.2756185-1-wuguanghao3@huawei.com>
References: <20251118132601.2756185-1-wuguanghao3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj500016.china.huawei.com (7.202.194.46)

The main() function only releases fs when it exits through the errout or
success_exit labels. When completes normally, it does not release fs.

Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
---
 resize/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/resize/main.c b/resize/main.c
index 08a4bbaf..71711229 100644
--- a/resize/main.c
+++ b/resize/main.c
@@ -702,6 +702,8 @@ int main (int argc, char ** argv)
 	}
 	if (fd > 0)
 		close(fd);
+
+	(void) ext2fs_close_free(&fs);
 	remove_error_table(&et_ext2_error_table);
 	return 0;
 errout:
-- 
2.27.0


