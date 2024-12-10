Return-Path: <linux-ext4+bounces-5535-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1AD9EA971
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 08:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17975188B1A4
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 07:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448A922D4E8;
	Tue, 10 Dec 2024 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="VUjc3sa3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939AF1FCCE6;
	Tue, 10 Dec 2024 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733815301; cv=none; b=H44odo4ckSHYrP+AwWyqRNSeR4R/zibKxmDs02TX3u56h2hTknRO5IKpAuKckqCH9OyIELq5M6Mv/udlYYVM61iSDJ+Ir/zVhgQ6MqPJnfZTtcrK8HfNALeaPlVlOkyB2bUa4hxywgyzKSd2o7zV3qRWRvyTUZ/Au1oo6TRc3hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733815301; c=relaxed/simple;
	bh=uwoTQGd50XKRwmHhcyRLGgeWF/OnpXo+mrRXAHkc1/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MJyDVGdag/FCaI9I7dB2MQk4vMkX6pzIZDX6lo0teYzFK5ZeKE4N7sUbbfKuXJiFfPV3yEc+9DvYTxemaDG0XO4RsaT5Z08dKtRYN2Aga+LTzcoN5qos0WjkaWF8+TnU4yKbJAWhgJDPCL6wfCD0BLIRidy0yDPhh1CBQOF81eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VUjc3sa3; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1733815197;
	bh=I6OUNlZ7q6hyKu9YRiOTtA/g+UIxdZdA2a3DziIzYZs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=VUjc3sa3ejqES2iqegxHVJ0+P1KzWYW25IblXjY9rdAJfQ5g5QSem28gSRwD+KAuf
	 D/y1Wt/elMjfJIw7SyifxRVTjH9g8E9Kf0l782SvbRI5gDe1EEgm1Sp3lviygW/qtA
	 7qIFiyU/TEzgqoLAbXA9Si6TAkUaGK+8W05LDsSA=
X-QQ-mid: bizesmtpsz5t1733815191tzukagc
X-QQ-Originating-IP: BQZx3pqtbXIOlFbutyZ1NwLboTopXuCOx+OBMpN1wwM=
Received: from localhost.localdomain ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Dec 2024 15:19:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8042686719195873629
From: Gou Hao <gouhao@uniontech.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	wenqing.lz@taobao.com,
	jack@suse.cz
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	gouhaojake@163.com,
	wangyuli@uniontech.com
Subject: [PATCH] ext4: make trace_ext4_ext_load_extent print-format correctly
Date: Tue, 10 Dec 2024 15:19:48 +0800
Message-Id: <20241210071948.12636-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: NZ/1hDUbhNR86Q+mBKPRG5Glc5Yn2SaZ1azwbDaDUS67mrtt5sjDDj8Y
	YuNGGQLTpqjOeBYS0LoiI2bhBHd7Lh3s7lKxHDfSPScloYcIobwfOqjXe2FG8zHczxoWNMk
	FpACm2W/Ku+DeTAlySV+qOKpgKO4dGmbAAqCSygO6m4Hh2pi7ZxgXco05eDi81leukN/OLD
	h93+Ef0bG4lwbcmdaqMlYpqUlFKPlZu3bRmSWQQcgddbWZBqtwy4dUvLUDgumhnHVCjYJmi
	KFyvTcL6771vRwn3LAxcSJXcyX7c6Y12Vy5Eysuv3vqmb6gomM4WjvS243oUanNCYDihH8A
	eMrQk4yZYHhWzi4KNXKsNdLyoGPFBrm9BoaHePTAiqdJeFh3/sIQSbNWwPk0vxX1k305Ej5
	S6icnavrIaPwqXT5eY8ZT9ZBV3KKEa127oV8g39ZoOTb09zgcXN7bpec4IcXJUN/OEeTRkl
	Iw4zzybFOYNnrQ7q0oC/zptp1lm6YCCZzCG9coHWPBIplMGLwNNl5Lx3yrpjnHcC3Kcnis5
	oKPEybopXG4bjjcDYve62ZNi+ndwKVpHvUw1atVVpQgWi3KUZZFIv3aWMbtSq0I4OM60D1z
	drK2SZAine2sW2kZpDs9aPXJWW7gMEZbJwmHmEI0uf7pA6Wtj9AsoouVZCaZf5iIzvndcKn
	mVXKd4c4ynkUFWcza861j/ULlfRyyn3o0ri0jSOUfpLFCTRPdNIqEmghdreJNxnWGY+ExTO
	X2mEdAkHZa4l//uF44J5jmIc+0dVxS/yLzJTcKxaBxC2ppVNzQjES4ueDZ6E0FYXab02qWu
	E0WBkwTl2RaE8KlclOenBMekPCPiyYwAql/H4ScVgGW2/jmstoPHMKRz1qrOXcH0Qkhx6aG
	FsLatCFsnZoUJmWU//jgZFfNCcuKvp8kEK0fPbPCyieeIvhzKoCSJJZ0RLHSByO5xnY5RAg
	0irqdou4REMis4JB0yCdkk7V076b7P4fY9cUG4/cNzGva7NkPUqH2n75JL70O/L/7M101Wj
	QKvdeYN5iE5lCPX/oExHb7q01RpRs=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

In commit '7d7ea89e756e', pass the 3rd param of trace_ext4_ext_load_extent
to _RET_IP, without modifying the print-format of it.

before this:
147.827896: ext4_ext_load_extent: dev 8,35 ino 272218 lblk 1135807 pblk 18446744072651077338

after this:
35.118227: ext4_ext_load_extent: dev 8,35 ino 272218 pblk 1135807 caller ext4_find_extent+0x17a/0x320 [ext4]

Fixes: 7d7ea89e756e ("ext4: refactor code to read the extent tree block")
Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 include/trace/events/ext4.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 156908641..55061c36a 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -1707,28 +1707,28 @@ DEFINE_EVENT(ext4__map_blocks_exit, ext4_ind_map_blocks_exit,
 );
 
 TRACE_EVENT(ext4_ext_load_extent,
-	TP_PROTO(struct inode *inode, ext4_lblk_t lblk, ext4_fsblk_t pblk),
+	TP_PROTO(struct inode *inode, ext4_fsblk_t pblk, unsigned long IP),
 
-	TP_ARGS(inode, lblk, pblk),
+	TP_ARGS(inode, pblk, IP),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,		dev		)
 		__field(	ino_t,		ino		)
 		__field(	ext4_fsblk_t,	pblk		)
-		__field(	ext4_lblk_t,	lblk		)
+		__field(	unsigned long,	ip		)
 	),
 
 	TP_fast_assign(
 		__entry->dev    = inode->i_sb->s_dev;
 		__entry->ino    = inode->i_ino;
 		__entry->pblk	= pblk;
-		__entry->lblk	= lblk;
+		__entry->ip	= IP;
 	),
 
-	TP_printk("dev %d,%d ino %lu lblk %u pblk %llu",
+	TP_printk("dev %d,%d ino %lu pblk %llu caller %pS",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
-		  __entry->lblk, __entry->pblk)
+		  __entry->pblk, (void *)__entry->ip)
 );
 
 TRACE_EVENT(ext4_load_inode,
-- 
2.43.0


