Return-Path: <linux-ext4+bounces-8255-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8138AC9E80
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Jun 2025 14:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5183AD58C
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Jun 2025 12:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C3C19E7D1;
	Sun,  1 Jun 2025 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="RnsmUaK4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004332DCC09
	for <linux-ext4@vger.kernel.org>; Sun,  1 Jun 2025 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748781468; cv=none; b=dW0UXtF4Q+ivBMm0d2cDwCwX3FdrA9cwawQaE5qGtPKLjB2bIs2uxBw6pjwnPp3gquDBxL2Z+VEOlJbntXHGXGm6nbNWlDBa4UXlMa9eO3kdo9azbrjTzpSbSYGoJkd4svabyzO7SwiHULlpqCTH87QtQvDV/wxwmjxx0ba2ak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748781468; c=relaxed/simple;
	bh=jdA1MovWP6++jmrFP/IQcZW7G2f79+mL4mTbN+RpBAw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gDBwndYK7JpbNnRtxT4P8OoLJK0TsJgff6U4kVeo5flmza6KvgCDRKU+g+YBZWWLpOQrpsSVJb2ndrF05qlfBNzM0bRxt7+/Bm8I1ikx/Qpnm8iiZww0bhf/Fvk2tWaZf541PKTVLgy14IiVl+GDE5+H3vXZDZhyBI9DcBv78VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=RnsmUaK4; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
X-KPN-MessageId: 2c6215c3-3ee5-11f0-a830-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2c6215c3-3ee5-11f0-a830-005056abad63;
	Sun, 01 Jun 2025 14:37:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=0bbP02LBAIehvOJnM35N5Khmgnvtg8cnyjAt3whIb7I=;
	b=RnsmUaK4SCksgblcRXqbZqZG9tptsFfpt6JKAIGzTDm7iQ68Ystzfwi46UxDtyLoZME9I5pLPWOS0
	 sJDvNAAWblvdljZb2syY156Rnbyidc1W/ex8NNdy6cyXpFD93SVj9WkLWvWfboz1tea1+H7k2p+ef0
	 yJQm/nFSnhTbq06w=
X-KPN-MID: 33|DQPFKjqykkSoSkcJx5wnHEXBB93B4qJOMgqI950GTf6Px5RBN5cbafCUUfJq56m
 GHE57RhikBGzkDJG6LzpHtx33ibzGMBbh1UBi2lyogBw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|BbiBPWsa44YK6oZGSshK0yd0Y0k/ItNMJ6OUgm0jxMo/ZgMDMCukjxmreMebpTu
 354Ms09ijXp7WOkgGS2aEcg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 0e46a6e0-3ee5-11f0-859d-005056ab7584;
	Sun, 01 Jun 2025 14:36:35 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: linux-ext4@vger.kernel.org
Subject: [PATCH 1/2] mke2fs: fix a misindentation in the man page
Date: Sun,  1 Jun 2025 14:36:23 +0200
Message-ID: <20250601123624.16583-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem existed since commit 3c22bf7e70 from twelve years ago.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc/mke2fs.8.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
index 4ff564ba..13ddef47 100644
--- a/misc/mke2fs.8.in
+++ b/misc/mke2fs.8.in
@@ -714,7 +714,7 @@ by commas, that are to be enabled.  To disable a feature, simply
 prefix the feature name with a caret ('^') character.
 Features with dependencies will not be removed successfully.
 The pseudo-file system feature "none" will clear all file system features.
-.TP
+.sp
 For more information about the features which can be set, please see
 the manual page
 .BR ext4 (5).
-- 
2.48.1


