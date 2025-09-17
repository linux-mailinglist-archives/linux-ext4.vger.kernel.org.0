Return-Path: <linux-ext4+bounces-10224-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA52CB7EC3C
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 14:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FAFF522F06
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 03:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E642F3C22;
	Wed, 17 Sep 2025 03:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GBOezzhS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D91B29293D
	for <linux-ext4@vger.kernel.org>; Wed, 17 Sep 2025 03:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758079710; cv=none; b=KtsrT2FvGrLI8GGUrm67x7WYUTilXYLHFyzZcq+y05JaUVoSa4o5rLQgpTSUXhuLBoUSMwBgw4KygdK4l9IEWf0vn0b87TbcYOT2Y4j6j3ST0/meAru5aRrNgRLbFgr1BOZ7p39Idj5/9eWKBFpA6LG4No+hpNIcrsToDRRC1ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758079710; c=relaxed/simple;
	bh=5Sbp0hGoNyLTm+zHAQe1F/DIN8tpDAeChrIATm3Wbqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QRavAbh0jb3oonw0Da9Sf4ecTxRkYLIdTcZfk6BxPgt08lszGPbPu/RlbDthxcLvcpDy8MpSLUD59ee2hAErWjwJ9U8jNfQX+/3QTKDlYprTUR2xu58As+cFjE//HxN+k9aZj4KXo8S/w8BU2EAOZm9PxOCFRrcPK3KGeKMThvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=GBOezzhS; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-116-225.bstnma.fios.verizon.net [173.48.116.225])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58H3SJDF001495
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 23:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758079700; bh=mGKSDhN5T2VNimLgAeha9hHp1yidahV9feqDq3H/xO8=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=GBOezzhS1oja81yw+kOWip3zbOQNYtA4X23HuvYUdvZT0CHBX2np0/XzZ/a/CcZrJ
	 ez3WxjZZPhR3Rp/q9uLqu2d0PEq5E6LTCxrGBP3OoJkW5Ky5pKsqUiBAsI1CwjUqC2
	 VflU1oG1rFDJyvchmrtfEa+9G6s8YARv5n22CbdWMc2WKXA2qNbSwZEi4fF0LqIzSO
	 5NcF9cFBsLCiB659dtRA0E0v1OH27T4UB+l3DH50xnj3K0Y4zu1B0PB3B5CWyPK5fW
	 yLdM365uKRLZieMIiqEPgxTU0z+SEiW+xgvULcL6X1IXqeNDp3zJIaCQ7jyKmY1ko2
	 MXo+M1ZhYsavg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 347152E00D9; Tue, 16 Sep 2025 23:28:19 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 0/3] E2fsprogs: tune2fs: use an ioctl to update mounted fs
Date: Tue, 16 Sep 2025 23:28:11 -0400
Message-ID: <20250917032814.395887-1-tytso@mit.edu>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach tune2fs to try use the new EXT4_IOC_SET_TUNE_SB_PARAM ioctl
interface to update mounted file systems.  This will allow us to
disallow read/write access to the block device while the file system
is mounted, once we are sure the updated e2fsprogs is in use.

Theodore Ts'o (3):
  tune2fs: reorganize command-line flag handling
  tune2fs: rework parse_extended_opts() so it only parses the option
    string
  tune2fs: try to use the SET_TUNE_SB_PARAM ioctl on mounted file
    systems

 misc/tune2fs.c | 763 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 496 insertions(+), 267 deletions(-)

-- 
2.51.0


