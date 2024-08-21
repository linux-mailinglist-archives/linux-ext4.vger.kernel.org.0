Return-Path: <linux-ext4+bounces-3828-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF4C95A142
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2024 17:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC051F21B22
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2024 15:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9E31474C3;
	Wed, 21 Aug 2024 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HrjDztLd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FA813D53E;
	Wed, 21 Aug 2024 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724253828; cv=none; b=Wh+LEsALP6QU2LTatmmYHN2i34R7E8Mw42VfhAcHCSnRmwmkxTu/CyeQve/srgeplTmyx9FCKoH7zRNOhb1VscxfuML0JJWzS8N5qKm6VW1cWy3+dlOUmBjl5GixsLwbbaUoTQiAxr+zqhReehXXaNMewiTpMf2bU8WGWZRTfAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724253828; c=relaxed/simple;
	bh=pcJvNcDCo8ydq8v8sbIJv4VhAHfJ8Uw7pEvW/CzqN+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=udr7f3IWDdfjJtML1xmq03cM4ld0SgRavTZhlFQo4LWIzxcumxzDaozUyYa1zSarbSoSOcTYOvrMexopSH6NNy/UOvucDI8TckqvXNuwQsTKtzIfSKs9IjQbIvKIJnSEzSxICxUmeeB6m1ZiwoQXYzXnuE0n53tJPo/4qVMu07Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HrjDztLd; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6QYQr92R1AccAwINWQDQpuoVGJxkVS2v7jw3cZF4s08=; b=HrjDztLdrZAvA9S7yJKRtvKlhY
	5Tzz+JWg2qeOaLtDzW3sd3jEZlQIzM8wevBNRcOqS5Py0Dn0MXBDS08u1YtREV6hCBS9mED5aFNo/
	LyfPWZFzGYTeaGjXXx4OYx4V0RngF0inM1vdScdtHLUssga3dwqdeOyAsJx0TMHjDAgU9BrZ3H2oi
	GFHPAnZ1Kkq8GPJL3sn3icBk4BSri5H9fZaslFm5fDF0XAxLdIr9LAexmXW9ZjrXJ0dapoxlvbA+m
	hXzmVyRbNPjD6bLHRGopNYh91Y8eU2oJlF3EbE5KUlKThpIvCa1JpmCUtfNQKI1U7hBl6eEaVhCif
	C+AOZmqg==;
Received: from 179-125-75-209-dinamico.pombonet.net.br ([179.125.75.209] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sgnBS-0034iV-Er; Wed, 21 Aug 2024 17:23:38 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org,
	Tao Ma <boyu.mt@taobao.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 0/4] ext4: avoid OOB when system.data xattr changes underneath the filesystem
Date: Wed, 21 Aug 2024 12:23:20 -0300
Message-Id: <20240821152324.3621860-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset changes some of the error paths involving dir entries lookups
and recheck that xattrs are valid after an inode is potentially reread from
disk.

Thadeu Lima de Souza Cascardo (4):
  ext4: ext4_search_dir should return a proper error
  ext4: return error on ext4_find_inline_entry
  ext4: explicitly exit when ext4_find_inline_entry returns an error
  ext4: avoid OOB when system.data xattr changes underneath the
    filesystem

 fs/ext4/inline.c | 35 +++++++++++++++++++++++++----------
 fs/ext4/namei.c  | 14 ++++++++------
 2 files changed, 33 insertions(+), 16 deletions(-)

-- 
2.34.1


