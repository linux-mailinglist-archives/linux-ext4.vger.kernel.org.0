Return-Path: <linux-ext4+bounces-7564-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A23AA424C
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 07:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE8747B9334
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 05:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02FC1531F9;
	Wed, 30 Apr 2025 05:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzRKI+7P"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16BF1C7005
	for <linux-ext4@vger.kernel.org>; Wed, 30 Apr 2025 05:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745990459; cv=none; b=fWWtvrMo0FulbAvDj1L4f1RJmcTFlp8Jrj3gFVQxBTEalsUsdiWg83yyVj2T9hMJTEK2sL78+NWv0Ll3XbYA6ujSglQ68QU/jRYEX9bm32HiXf/TwA9Y9QItQqbcftPVUQGPKYaDr0zeGP5FuphQsezUH1tDBcGmxdzY1TQLDs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745990459; c=relaxed/simple;
	bh=rYORFkNt8TuFPNhsEcFmjBYjlDzjdFVsu1jvl9OYzGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T77MSpsfnDJ90EA8Srb+lEj/84toLA5hK2Uk6xcSxjj/bCMyXBGzWQ7ktcEXQH+wQldhAACOG3C1QQEWwwnIJQFZ3w27LQSNJ9HJ1J0A/2+K2oRv2LP4WrauULmQXbCeIihoBb4DYillSxOAM6tO5FfKIKm8h8e+vT6Kvl6uAz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzRKI+7P; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736c062b1f5so5858828b3a.0
        for <linux-ext4@vger.kernel.org>; Tue, 29 Apr 2025 22:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745990457; x=1746595257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CrcQJV9gcpaAcbA4U+AJjy2JmBJyc6IQC00Mkigbv5o=;
        b=NzRKI+7P+XuAVzVLO78PW1gt4OB9gTpRmakWc/s+yvLI7Ht2QPCY4qsEQj99XUkrTk
         //e491N9XdnlU7FEXJ8uKxGSdNbNgTO7rOJuVRQiy4cfmCN/VWixUHTksARYoDzRb/Vq
         oIRTGaXwTr4J9S1iH5mDv3MNmcSEiSiNmclWKDgAiLSnsNwR7WbBCIFCzYF5OBuoBwnT
         erfv7hjEfexFzNKAss2s+lzeYQpuxHs4Y1SNWKh+Ed2Ulk9iv2Ns5C40lK63dSn8k4oz
         Cx8hv2jVvh+daYouvG8sZbj8WeDRWODAO1qc3qpGuZ8zh8ZyMHdCBGDdd0hACB+5MNN4
         k87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745990457; x=1746595257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrcQJV9gcpaAcbA4U+AJjy2JmBJyc6IQC00Mkigbv5o=;
        b=hXrYaNL/C+2r5zliyxCXe6k8GTs9QBFkagtTyHL1JB7PRx8rYrToNVXkMDMmwfWX7K
         SRu7Iyi5VPUmF5xpL1bqNr2GEc/O16wkJendTul8+omJTDDTPPNOIAY09vxR9PSpxOvf
         wJ/SpZPkhxQCaSom3ogPhFQbTp9xaid9mMcklKl4jwiwQqLUbeT0u0sntD3gv8yaVm7w
         ihQSbznNO/9nJTb+kvEo9tzgpSrE7O8mi7zLsWFOrI6GdDUg0W5RJ7gJ1+rIrJN4z80M
         KQLuh7KV53yaY5Z00s+dEutWSKIWQfoo9mB/ZSXnAKiLIHsg34Ngzn+McfhUS0A46PvJ
         5gwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvme0uFxFkzlEILAaFnsylHJTLVEckar2pjn9Wegfh5K/SVojk1qiks87MXFtoaCe6tWPCzoBoG27G@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4LECF3ZreOF6zRrSV/NjTbkTuNRYz3FDLiisu1N19ww2l8s0R
	CngFH4z3v3plry/cS5codgvgu9x7pcXp4MSeWNhrcGQ/6jN664qp
X-Gm-Gg: ASbGncuVeqLeBqUSnpM4MzizqcOtoPHEcU82PqSa1E0V3wS5tdyrrmc+pIE7RSo29eA
	MRkfC2NqdYsxYS5NKkRhfiYfxTVff1CknErIxSVvL516naYX6y3zogGUibOrLL5B79S7I7vbmZk
	4Fqsez5UKn6mQHrTuw7V0dPmN99h29PaxyD1P9da3EwlsKmLMlhVQmOX90G6ep+Go8Yq/4cNUN/
	Jx+9MohpTX9PVIxPUVLhOi8UHV6f7ECFlizz89v/ON8q5j4u0BIE+23BRmGtfNo1qM29PN34LaU
	Q9v/avt99Ap8mRWN9V12A3pzRVbSwB3Ps4wHzlJ60vj14rw=
X-Google-Smtp-Source: AGHT+IGUiMzIUNvdV4iNfxTZs/cmYNlZMw+z1lRIj6EF/eaaUxBvD4TKTeUzjQobXrImXNyd9NUBvA==
X-Received: by 2002:a05:6a20:6f8c:b0:1f5:8072:d7f3 with SMTP id adf61e73a8af0-20a89325301mr2537533637.30.1745990457077;
        Tue, 29 Apr 2025 22:20:57 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a3100dsm735388b3a.90.2025.04.29.22.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 22:20:56 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>
Cc: John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-ext4@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 0/2] ext4: Add multi-fsblock atomic write support using bigalloc
Date: Wed, 30 Apr 2025 10:50:40 +0530
Message-ID: <cover.1745987268.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is still an early preview (RFC v2) of multi-fsblock atomic write. Since the
core design of the feature looks ready, wanted to post this for some early
feedback. We will break this into more smaller and meaningful patches in later
revision. However to simplify the review of the core design changes, this
version is limited to just two patches. Individual patches might have more
details in the commit msg.

Note: This overall needs more careful review (other than the core design) which
I will be doing in parallel. However it would be helpful if one can provide any
feedback on the core design changes. Specially around ext4_iomap_alloc()
changes, ->end_io() changes and a new get block flag
EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS.

v1 -> v2:
==========
1. Handled review comments from Ojaswin to optimize the ext4_map_block() calls
   in ext4_iomap_alloc().
2. Fixed the journal credits calculation for both:
	- during block allocation in ext4_iomap_alloc()
	- during dio completion in ->end_io callback.
   Earlier we were starting multiple txns in ->end_io callback for unwritten to
   written conversion. But since in case of atomic writes, we want a single jbd2
   txn, hence made the necessary changes there.

TODOs:
======
1. although this survived quick tests and some custom fio tests for atomic
   write, but I still think we need to add more tests for the corner cases.
   Will work on adding such corner test cases to xfstests.
2. Many fsx related tests in quick group were failing with bigalloc. But those
   were failing even without these patches. Need further investigation.
3. Finish more thorough testing of the series.
4. Refactoring + Cleanups and a more careful review of the overall patch series
   before sending v3.


Ritesh Harjani (IBM) (2):
  ext4: Add multi-fsblock atomic write support with bigalloc
  ext4: Add support for EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS

 fs/ext4/ext4.h    |   9 ++
 fs/ext4/extents.c |  69 ++++++++++++++
 fs/ext4/file.c    |   7 +-
 fs/ext4/inode.c   | 231 ++++++++++++++++++++++++++++++++++++++++++----
 fs/ext4/super.c   |   8 +-
 5 files changed, 302 insertions(+), 22 deletions(-)

--
2.49.0


