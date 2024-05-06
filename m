Return-Path: <linux-ext4+bounces-2332-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE878BD3F7
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 19:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8C61C2161C
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 17:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D951581F6;
	Mon,  6 May 2024 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OyO2rSXX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aiI4WXO9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uum+m2Ag";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RabKynCV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFBF1F19A
	for <linux-ext4@vger.kernel.org>; Mon,  6 May 2024 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017298; cv=none; b=XVqp77XzpUVndu1AVhapxd6jQ5sNgOCiYDdljGsqvZLViUxB9fKm+IZUOKbO8W/CILXuLIbyjcMatixhFTrqOkzr8lFc8hKbSGBWo8RJHBF/d6w/L2CXQKrcp0z50doORIx81R7XIMo2b47bPvNba3Bh22lguFb0hLAMT1amkho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017298; c=relaxed/simple;
	bh=KmxqQS4lO+6gJFFgR2lVc+09ZJZ7iMTHZYfjOAdR0c8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tbKwpXwEx01rkBQnETCh202BGgMEIX9fUGQDDxuWBmET5R2N8rYHJZPP6QKyz54n9tEj2ORhUBhbN7eCDzS3GBOa6A/o2R5vvZNU+zGVOC6//e6s7EycfA71VJa1Wy1Z9CzR0ar0GPEM0CQXNJvE5ccvGg5np1EJugW5e4+XJZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OyO2rSXX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aiI4WXO9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uum+m2Ag; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RabKynCV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ED5F3219A9;
	Mon,  6 May 2024 17:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715017294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWZpYpMUbL+IfxO74vHcOZz8Y6BKjEPsvhQKI56HxYc=;
	b=OyO2rSXXnS3hm/ISIJ0qCEyQxmOb+rii5WczMvbgenz2OoJFBa5oiwx60kznp8Y987Szim
	YGHpeNVg/mAUSVo3rIaCsrsh6cZkWS7yYbRrmB41iDdJfY2SaJkrGYhSk82Cnk0c3Jfvmx
	De0uIPzOhQP3LqJUHCA2/+/1swSXcm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715017294;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWZpYpMUbL+IfxO74vHcOZz8Y6BKjEPsvhQKI56HxYc=;
	b=aiI4WXO9cuem+7cjp+6YeXzRhtLLbfn5WBFjkJKYFQ6k01tmIAzc8KI88ZukTi8qybkBfr
	WByIa/cBh8gBoWAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Uum+m2Ag;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RabKynCV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715017292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWZpYpMUbL+IfxO74vHcOZz8Y6BKjEPsvhQKI56HxYc=;
	b=Uum+m2AgXOgvJ7lNqwFgar2IKZ1K3iwuKub0vHczL48XEAe1pEJ+9BIhQQH4m1u7l06dfW
	zSdxKIqXPHQqzIweYcaTsXjBYuxndf43Ns1nNBe56H61szuZYh7pXOP3r6CsTiilZhNL/7
	mwPFPuuGX25eJ8AM0E2tzK0us8NV8+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715017292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWZpYpMUbL+IfxO74vHcOZz8Y6BKjEPsvhQKI56HxYc=;
	b=RabKynCVDke8WCW38e4s+Z3wQkr6sYmfg0r3sgZg9kyrlMCm5HgsI2tKFmm0yGuKmVC8Lt
	ed+teLo/oKQa9uAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBA1913A32;
	Mon,  6 May 2024 17:41:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YqdgMUwWOWbyMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 May 2024 17:41:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 11873A4DF8; Mon,  6 May 2024 19:41:32 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-ext4@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] e2fsck: add tests for EA inodes
Date: Mon,  6 May 2024 19:41:18 +0200
Message-Id: <20240506174132.12883-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240506173704.24995-1-jack@suse.cz>
References: <20240506173704.24995-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=28059; i=jack@suse.cz; h=from:subject; bh=KmxqQS4lO+6gJFFgR2lVc+09ZJZ7iMTHZYfjOAdR0c8=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGNIsxeysyg3MIyJPrFlqzd7VesNT8ryoiZjPdNFr/z6dv9Ow SM66k9GYhYGRg0FWTJFldeRF7WvzjLq2hmrIwAxiZQKZwsDFKQAT6Wpg/2cf5yzwpsm/silZtKpEzZ jrg+7nw24Xj0W63Fpr9ebRpuLdV91WR02Of259absw3x8OffFg1Zjra+Xe3/eYN5njjdYbnZDgLqFQ 4d7XopJaH6y/udRPv6G8kteje59UR/OOzzIhrmcDHM3PLrXf4xgpeUfJXfOqVc5RXcFi9Rku187avx ESfm3N27u8SYArli//t5LvrQNVya/SDqxfxLP7wcvzSmXa/Ew67b/LTDeb9c1yD38k12Xd+yUpovq9 JPP/rIK+tfVL9D8xfW0P5z5i4ZPsNXH1nscvJzUw/P7XMX19L5O6HYvzxYL5Jo2z/+b7TeUuf/3Lb+ o79+6lJhzPfdRkOu8cD5u3Y7YYAA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: ED5F3219A9
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

Add tests exercising EA inodes and testing various types of corruption.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/f_ea_inode_dir_ref/expect.1           |  12 ++++++++++
 tests/f_ea_inode_dir_ref/expect.2           |   7 ++++++
 tests/f_ea_inode_dir_ref/image.gz           | Bin 0 -> 1822 bytes
 tests/f_ea_inode_dir_ref/name               |   1 +
 tests/f_ea_inode_disconnected/expect.1      |  23 ++++++++++++++++++++
 tests/f_ea_inode_disconnected/expect.2      |   7 ++++++
 tests/f_ea_inode_disconnected/image         | Bin 0 -> 1048576 bytes
 tests/f_ea_inode_disconnected/image.gz      | Bin 0 -> 1779 bytes
 tests/f_ea_inode_disconnected/name          |   1 +
 tests/f_ea_inode_no_feature/expect.1        |  12 ++++++++++
 tests/f_ea_inode_no_feature/expect.2        |   7 ++++++
 tests/f_ea_inode_no_feature/image.gz        | Bin 0 -> 1817 bytes
 tests/f_ea_inode_no_feature/name            |   1 +
 tests/f_ea_inode_spurious_flag_dir/expect.1 |  11 ++++++++++
 tests/f_ea_inode_spurious_flag_dir/expect.2 |   7 ++++++
 tests/f_ea_inode_spurious_flag_dir/image    | Bin 0 -> 1048576 bytes
 tests/f_ea_inode_spurious_flag_dir/image.gz | Bin 0 -> 1598 bytes
 tests/f_ea_inode_spurious_flag_dir/name     |   1 +
 18 files changed, 90 insertions(+)
 create mode 100644 tests/f_ea_inode_dir_ref/expect.1
 create mode 100644 tests/f_ea_inode_dir_ref/expect.2
 create mode 100644 tests/f_ea_inode_dir_ref/image.gz
 create mode 100644 tests/f_ea_inode_dir_ref/name
 create mode 100644 tests/f_ea_inode_disconnected/expect.1
 create mode 100644 tests/f_ea_inode_disconnected/expect.2
 create mode 100644 tests/f_ea_inode_disconnected/image
 create mode 100644 tests/f_ea_inode_disconnected/image.gz
 create mode 100644 tests/f_ea_inode_disconnected/name
 create mode 100644 tests/f_ea_inode_no_feature/expect.1
 create mode 100644 tests/f_ea_inode_no_feature/expect.2
 create mode 100644 tests/f_ea_inode_no_feature/image.gz
 create mode 100644 tests/f_ea_inode_no_feature/name
 create mode 100644 tests/f_ea_inode_spurious_flag_dir/expect.1
 create mode 100644 tests/f_ea_inode_spurious_flag_dir/expect.2
 create mode 100644 tests/f_ea_inode_spurious_flag_dir/image
 create mode 100644 tests/f_ea_inode_spurious_flag_dir/image.gz
 create mode 100644 tests/f_ea_inode_spurious_flag_dir/name

diff --git a/tests/f_ea_inode_dir_ref/expect.1 b/tests/f_ea_inode_dir_ref/expect.1
new file mode 100644
index 000000000000..fa6a872b8bf7
--- /dev/null
+++ b/tests/f_ea_inode_dir_ref/expect.1
@@ -0,0 +1,12 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Entry 'xlink' in / (2) references EA inode 13.
+Clear? yes
+
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+
+test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
+test_filesys: 13/128 files (0.0% non-contiguous), 63/1024 blocks
+Exit status is 1
diff --git a/tests/f_ea_inode_dir_ref/expect.2 b/tests/f_ea_inode_dir_ref/expect.2
new file mode 100644
index 000000000000..24d059a300a9
--- /dev/null
+++ b/tests/f_ea_inode_dir_ref/expect.2
@@ -0,0 +1,7 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 13/128 files (0.0% non-contiguous), 63/1024 blocks
+Exit status is 0
diff --git a/tests/f_ea_inode_dir_ref/image.gz b/tests/f_ea_inode_dir_ref/image.gz
new file mode 100644
index 0000000000000000000000000000000000000000..483cc725ee29f2ba26c3cff2571741d1e0c0da49
GIT binary patch
literal 1822
zcmb2|=3tQjWs%0f{PwPIMvSWr!-tz^-5;y9MkR^bN*v7En9K7-h}Ci7jG!ak8X|8O
z%CEb!#M7`dWQrLptF32|kbazw+?Pems|2J3Z7N@_Tq+p2Ix~<ftiN>bP2Ze-S;@gh
zSHJ&mtu)TRcYE&toFDwo5ucnGy0UC!XF0#<y&4kCp}bM=?EZzT125H{kA1P)@0gI&
z+HYr;2L0W4tn%=k*SFIBe<giQ&E{bK_}Bb@!MmIH<tlc4UAu2S-~R3I&ulwdXj7As
zQSx<j<oEvY^L3vteYZdVrsDIFm!Ea#*KhuMFsQ<&<V@UdqvBFIbMNp!n!1<o%UD<E
zeM^|B`?Iy^wDgO$dty4j-rZ;;67;XXr6`JL(b-(v_@0)xyVrlc<-2}fRc-Df76u4d
zw>-?c%;Znx>Z`Lh@z}>PZ_+%j@`ht+QTZC_w?#X5@BS#e?_7W;KVN@O-detXURjQ>
z?@#4&=q^>h+T5&v?AxyhKeMBs4>mh9M^58^;C3YD-?wisU;e&z_|TvEnORTlKm4Ei
zX@CB&i_3$4f48ZwSC~BIzyH6Ymnm7N>ovrF@*h?Gzi`JBdy(mX+8<5&9}x3NzRUZc
zbK%K)4LzWwsr`S(hNP8ucfXL)=y~<wL!HJJ=0E8X8#MOZ@jP)V5{-WP^Ry+@Qw$6a
zap7sdRu!kNJvQgg&M@WJ+w1+0I2UtN>wO7by?JTj(v|;go(SA>(v;Jl?)`Gx{-yiA
zh4$U8w`*BvQ2FGoeOb+fQ$KDTdARk@pW@s9Gv9H1s!9(AlE12=f#j~__;(ym683WZ
zwr9_JU;iI;W5cQM_e$r!4whf~b^ZU1KWkm1{x941yiZ|$`TH}nj&apxKz2)T=Ksr^
z@BCXY^KRAk+^>%x{q;Yd6WM$3d+@*ae{<^YM?L@Feq6fr*7siB8~>*|EsfjW`sID0
z_VmL|KmSYX&$0e>x9G2O{*s^mbM9GQ+*z2%KjWDH*Q>iviAO(9E3VC{-D-I3!{ceO
z?QyrQt$v;2W!vl#_5bqkc@<A`(yip9jsEMNeperzv@^XmS?2ZsAOD{Isy@Hu=XSgK
zw_Y00kgi|H3lBOhjO|TdYA%1tIse7y{I!T{t;d4n^G{2PU{N?KG#Ub<AuuRIp!JJ*
Mr-_~x1A_nq05M9++yDRo

literal 0
HcmV?d00001

diff --git a/tests/f_ea_inode_dir_ref/name b/tests/f_ea_inode_dir_ref/name
new file mode 100644
index 000000000000..e43cd69502f8
--- /dev/null
+++ b/tests/f_ea_inode_dir_ref/name
@@ -0,0 +1 @@
+true ea inode referenced from a directory
diff --git a/tests/f_ea_inode_disconnected/expect.1 b/tests/f_ea_inode_disconnected/expect.1
new file mode 100644
index 000000000000..afc77aea6d11
--- /dev/null
+++ b/tests/f_ea_inode_disconnected/expect.1
@@ -0,0 +1,23 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Unattached inode 13
+Connect to /lost+found? yes
+
+Inode 13 ref count is 2, should be 1.  Fix? yes
+
+Pass 5: Checking group summary information
+Inode bitmap differences:  -12
+Fix? yes
+
+Free inodes count wrong for group #0 (115, counted=116).
+Fix? yes
+
+Free inodes count wrong (115, counted=116).
+Fix? yes
+
+
+test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
+test_filesys: 12/128 files (0.0% non-contiguous), 63/1024 blocks
+Exit status is 1
diff --git a/tests/f_ea_inode_disconnected/expect.2 b/tests/f_ea_inode_disconnected/expect.2
new file mode 100644
index 000000000000..a67f9445048c
--- /dev/null
+++ b/tests/f_ea_inode_disconnected/expect.2
@@ -0,0 +1,7 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 12/128 files (0.0% non-contiguous), 63/1024 blocks
+Exit status is 0
diff --git a/tests/f_ea_inode_disconnected/image b/tests/f_ea_inode_disconnected/image
new file mode 100644
index 0000000000000000000000000000000000000000..f24547c26f63603cdf8918d3b42d518d8e31504a
GIT binary patch
literal 1048576
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
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
zAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
z2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
zAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
z2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
zAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
z2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
zAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
z2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
zAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
z2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
zAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
z2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
zAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
z2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
y0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FoIU0)GK&7lxGp

literal 0
HcmV?d00001

diff --git a/tests/f_ea_inode_disconnected/image.gz b/tests/f_ea_inode_disconnected/image.gz
new file mode 100644
index 0000000000000000000000000000000000000000..f440f2052f48dc0489c8d209fb050d96665facff
GIT binary patch
literal 1779
zcmb2|=3q!-uuNlMetXw9BgU11{lm@voX2WSQ=(k?pCxR)Va8Sz$?CXpM$pl2jVYI$
z?PD(1Et%yK#UkzK=znR>k?sl&xi5><Z8>_msy;qhxwI-^wdYEaD{`-`HqSOS^vzXJ
z46fZDKg0a}+3MeEWz+u~w6uyd1%yn_4CYO=2)jI0;8;>@RK-Du<x5`Ao0n^{Jc)DR
z)v8ZHD{Et)?^yhM*S?+2Zfoq;w-y-OtH0d;eBQ6O^VGA}o7dU>`nJzFTD<@9zr*gw
z!vE!6`}_LlW_i2chxLtb$6J4W`*WWE{+mVlnl>`Oo}Y`IIkR4Vb*jR@snasnA3L`2
z>N}mytM>)uRj{|eK7T#A)?Md&>y-Z+1N<gCZdqCWV)Mogx!1SG?f$s*vi|zB8jK8J
z(C|8QtKS}>e>q#Drs~}F-`0?G%CP0{!VtNh()9f?ax!oJw7rj68fRx>WwvjrrB&e*
zhm8MW?_PWPzl`|2)A@YLOudGy0-OK*{U~0x|GN0Ung3^cssBIlKm1hv<K67?{=e&=
zME+);x#W+1)yGTfneqP?Mm&-4^8UAQ2QDf*@gHMDQs&*QFC;X2p1pWcr?G|kPx_1v
z8hh?2ru_7Y5Q%#yu&G8(hfBYlBXXb3e@k|VM}Xvs*Qb0I-_*^%`us}Y)>kiY)zzxx
ztx|k5GuLEx@zUaDm+It-IQA|S+5Yvu_sdQDmu}l9`pve;uBFkS^iA*S+xLA_iyl3>
zxb@GU;@kfN-w8hX`s~;p<rA-0uifcB;riO&Mg0mbC&M47t%%xN^-sSwI;`UT-0PP1
zf9q!bcaw{{5w_%KepNI`+qGPfhIz3&-31Q4-11K{D(i1J-}ddV?|m!#_-lFnx-~~W
zSZn^TwvPkq`D1@A?tksY{g0oteZ6a%5LLgd>ffqQtx+*K_hi2Bi;<tc%0BmA<&Pit
zK7JGrPv^<}=l|XI>w%lRFDsJD>i(_Y{`#!<y87y*oy9Y2=Sci~@NVg?_VY`=$KRg&
z?Q;5sxBGYV!vhBk!@S8$=jF|LFK5o%8gZ@lTyT8;DN7A3>PCe|Ltr!n24x6vz0|)a
L>@2~+Aiw|sY0a}*

literal 0
HcmV?d00001

diff --git a/tests/f_ea_inode_disconnected/name b/tests/f_ea_inode_disconnected/name
new file mode 100644
index 000000000000..ce04192e8777
--- /dev/null
+++ b/tests/f_ea_inode_disconnected/name
@@ -0,0 +1 @@
+ea inode that is not connected anywhere
diff --git a/tests/f_ea_inode_no_feature/expect.1 b/tests/f_ea_inode_no_feature/expect.1
new file mode 100644
index 000000000000..f6a232bfc8f3
--- /dev/null
+++ b/tests/f_ea_inode_no_feature/expect.1
@@ -0,0 +1,12 @@
+Pass 1: Checking inodes, blocks, and sizes
+Inode 12 references EA inode but superblock is missing EA_INODE feature
+Fix? yes
+
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+
+test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
+test_filesys: 13/128 files (0.0% non-contiguous), 63/1024 blocks
+Exit status is 1
diff --git a/tests/f_ea_inode_no_feature/expect.2 b/tests/f_ea_inode_no_feature/expect.2
new file mode 100644
index 000000000000..24d059a300a9
--- /dev/null
+++ b/tests/f_ea_inode_no_feature/expect.2
@@ -0,0 +1,7 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 13/128 files (0.0% non-contiguous), 63/1024 blocks
+Exit status is 0
diff --git a/tests/f_ea_inode_no_feature/image.gz b/tests/f_ea_inode_no_feature/image.gz
new file mode 100644
index 0000000000000000000000000000000000000000..596d69a1c990ee5b79c7e2b291904fe5a5aab4b3
GIT binary patch
literal 1817
zcmb2|=3oeZYmvsl{PwPIMvSWr!-vY*zEYDpf|5jSXEa|;x-D@cRg|SQ!Anp-XkiBb
z-vZZP6SIUe18<3lyz!hgS)N^AjKAvQWVx1Q9917f1fo`T+?plgeel)Bb@^qR&EmIS
zZ1MT}w=VJCnc3gVp4&_RJ1j75k3hpBsqXe7j=z<rH-!!r#HDY}e~~$*;{N5!Q(tw9
zYhM+}+PYjX{p)YFWsfVJKbOumR-d}ZDwHcR|KGpY^)}nzUjIEWr+RPE!w1p3&*jXL
zKi>SCzelIuEc@TLS2z3T{eSp;W#e_fId=Dd-MlXS{`{fE3$vfyy1Fv^bA+btPycNm
z^_K77M87;J6#aqw>9X(N%#YuHd*b!(PoEq*e%i};6&jvcoB#fIjYZDAy1m!eRsVdV
zy;@k60Rjq?x8Ay_{IEZ2?X^iMKQ>BD@X_=?v~I%Gs?WPF>P@YxmcIY+HJ|L#TIa*c
z(yN^pvwv&(RsM8eR_0m0(D)nQV<tUiir}o&t1r(=xc%^)f%*UCQBpto|I{D-v%co{
z2jPu>qi5~4pWt!k|MB{re=>7U*K3IV<UgwVf8mZN_9D~&v_G2kKOp9le3$n>=facq
z8hSuUQ|teX4M{8S8o!s(=y`SFLY~GJ+dt_M8#MM@@jP)U5{+K^^Ry+@D+~+{QQ^zA
zuBJt<HB{fW=9<U#@|PR`1n?yuFIgHjSF=}J_v>@T_6u^G{@f^3?cV-Z^;@Z4@tcF6
z6~DA}I_Lkf`w*v-y!bJD_~+05x!;ekRQ7oNW7ieIC10N|1Cph`*If~8F(}iq|1$M7
z_x1leceb7Rey^(e^<?=YU-LgqyjklS^<T|=d7r{s^Y<RIj#1Xzfb5pZh5s*azwvLq
z$h$Sy-+q1k=db^DpUA#{<w^hE|4AvkpY{Cz@8eRXcfR+YyZJwL;o`XM?LXcZTCZ!d
z{QO^io^AP)-$#G7$M=4gx8Iw(r#iQoU*dTG*R8v~#BYB(`)qCH>+Y?UJodRacK!cw
zZsNr0|56P;ANgv(?|o<cxw7M*FS35Vzv0Ed?WX$W`h`7<o8|BAj;Q}X)8hZO^d###
zwzD5+=fXn{3uA}mk>|6IrB@$IuiExB)i=ZD>(^;h92v2w92FW3fzc2cj3E%<QO{%{
Lm3D)HL4W}Oi~P*4

literal 0
HcmV?d00001

diff --git a/tests/f_ea_inode_no_feature/name b/tests/f_ea_inode_no_feature/name
new file mode 100644
index 000000000000..b357afb47c6b
--- /dev/null
+++ b/tests/f_ea_inode_no_feature/name
@@ -0,0 +1 @@
+inode with ea inode but EA_INODE feature is not set
diff --git a/tests/f_ea_inode_spurious_flag_dir/expect.1 b/tests/f_ea_inode_spurious_flag_dir/expect.1
new file mode 100644
index 000000000000..19999ab79306
--- /dev/null
+++ b/tests/f_ea_inode_spurious_flag_dir/expect.1
@@ -0,0 +1,11 @@
+Pass 1: Checking inodes, blocks, and sizes
+Inode 2 has the ea_inode flag set but is not a regular file.  Clear flag? yes
+
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+
+test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
+test_filesys: 11/128 files (0.0% non-contiguous), 58/1024 blocks
+Exit status is 1
diff --git a/tests/f_ea_inode_spurious_flag_dir/expect.2 b/tests/f_ea_inode_spurious_flag_dir/expect.2
new file mode 100644
index 000000000000..a35477094496
--- /dev/null
+++ b/tests/f_ea_inode_spurious_flag_dir/expect.2
@@ -0,0 +1,7 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 11/128 files (0.0% non-contiguous), 58/1024 blocks
+Exit status is 0
diff --git a/tests/f_ea_inode_spurious_flag_dir/image b/tests/f_ea_inode_spurious_flag_dir/image
new file mode 100644
index 0000000000000000000000000000000000000000..f323b6131cec7d37d5864ef02ea0f24de090a8fe
GIT binary patch
literal 1048576
zcmeI*O^8iV902h1K77oWg%XL)upuNGYBtI&SSTe*B8oH{UkfH1F&1`g$U;hF{WdmM
zN|J0)R^(%CF;ZB&&Uw${#$am9yz$QO)S3J7&OPV;fA{{+yv3clAt(e0<SH<l0<VWK
z5EqYXA&kUjCGBgM{<sqBXk4W7xELG`p(u8Js5INPwp*XIkDHe^<HlfIJeVEAk=XyS
zo2U04yuNL2<Ho{UXEq*R);i)}|D5y34i`2aKHq<L>(YCB7JXi{=E?j@*c|%49nly|
zasAuUAK}_2<(}(t=koH7E?8gF1u^6n!oH7(KK90-m&Cd%)<?CGP)(CTEZY}cdO8w%
zt~EEt`SIe;&7I@ywu=A(0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBo5fIv~4
ztA;N{QN(9|I#5RA$O-`h9TKR<r0)xr>e{$$tyimS<3@Uh?{%%Wdi2D}Q>%whj2u7Q
zf!V>31PDxtKz#1??ZAeWeJRh&`Twrg%Ks@DRHp<8%m{&$|NU<+G@p6@+?ntGGs3}1
z5Xey=<^O@P9hXz=@;}ErK+HJ{$p4(LzSwgYkpH>g0pibDK>p`^^~IjMfc($>4iJCN
z0`foSt1tH41>}G3cYyeF7LflrUwyIXE+GGNzXQadvw-~1`Ra>3cY$*L=WZc>0t5&U
zAds6t@zX0aI`n7Ah9y9t0|L3tcj6^LfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FqeB2sFk9hud|!&iBcc=^E+x
z<Gde=pVdQX$DWq0*0tvQ&_kHp-0b~SNzJ~ON?c3tPM%D;P=wGQF0Lr|@nih*-tJsK
z*XYi;CK}b%-ifyC&UUZXb!S`?jjHGDL|aZ>yV3Kp?{)S1uk&9e%%9}2+x~L=v)gI@
z+qApfET{SJ&H8fW`K@1>>@U#&oNQ=I=L5Ju6we{f!@uT#H7stP-uT~t;{T5fsZOSB
zx{>mK>C18-Ipu#jZtDaH5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PIJbfm%GR^ltlEvCfWl
zPORyzuRXCU1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
zAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
z2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
zAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
z2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
zAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
z2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
zAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
z2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
zAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
z2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
zAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
z2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
zAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
z2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
zAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
z2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N
z0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+
z009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBly
zK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF
z5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk
z1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs
z0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZ
zfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&U
zAV7cs0RjXF5FkK+009C72oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7
r2oNAZfB*pk1PBlyK!5-N0t5&UAV7cs0RjXF5FkK+009C7rc>Z6Uy%fq

literal 0
HcmV?d00001

diff --git a/tests/f_ea_inode_spurious_flag_dir/image.gz b/tests/f_ea_inode_spurious_flag_dir/image.gz
new file mode 100644
index 0000000000000000000000000000000000000000..af19132ce100fc006c8b83832683dbf2bcab6b53
GIT binary patch
literal 1598
zcmb2|=3uD*Z;{5p{PwPYhi{+^`-l6#56}20=4G5>maM)kvt`z#q=QbHfs+<ZId*72
z>*U@u5fM=e+?o@=-o6o`=~<?s{V6@yaFapy^}X+TZFw$z;CuJ{v(@uG)$eNG&-?wV
z`d;jw>zxdzvR18lCHVT&vqaq_rF`wV>^xgfUwM;OT$N*^bh>Q+>MecQ`P*x&?moKN
zyK&FX{RWRb{{1_iH|JjYhg;uV&%XX^em=)y->362zUTSBe>0c2xm%xp`@!A4%*M=z
z`=^B@6`Q1eFO56?-e`)wR`HkXpU)k<U%Tl@TQGk^eA&l?r|0e46FYJG)xan9N~?~h
zOt`)A%b~}eFZTZ0d);n#ZE|?I8z%z<{PCIQ8}`_FTIyDn<?~N9q^zpskPckg_aygs
z<yI@BOaFN9pN@+E`l564@@qZwXIRu}oczP^hq1Tg`s-`!vvm6OKmT8L?VSCG|5~5y
zzr3n>ZT{Xk^WEP@m##nZGwxNctkC-(p!bRYsp|iLI9$}#ne_|{Vm7UxcE;mxeaeFB
zOJ}U0Zi7+>`c0M}KW0BQZ|>)dPxI!!{CzL)<mz8B*W<I-w##f>75aVedXe_pu+DE%
zFFzOl@Hi5X6Lan6^|R;gx1LOUCAg$?ss2}vOI3!ms#r3=&hxcx>R4G^X&SY@-ui!N
z(n*{9)xZ6}+3yTJQ$PD#$+xMQ|Ejl|0oCuaxvzhr{?4?uE8PVO*YEf*IrsIy<x;1k
z-!2OK`}MDX^0qU_m%VoV$3DOO+f>c}s18Qu9k{=K+VrH{>#UWLGp5hWSpVzR?4kfv
bC8NC25Eu=C!5acoF1d$inN4J15MTfRZKqU&

literal 0
HcmV?d00001

diff --git a/tests/f_ea_inode_spurious_flag_dir/name b/tests/f_ea_inode_spurious_flag_dir/name
new file mode 100644
index 000000000000..8ae52ccf02f8
--- /dev/null
+++ b/tests/f_ea_inode_spurious_flag_dir/name
@@ -0,0 +1 @@
+ea inode flag set on a directory
-- 
2.35.3


