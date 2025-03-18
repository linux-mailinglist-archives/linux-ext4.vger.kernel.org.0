Return-Path: <linux-ext4+bounces-6857-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C66D2A667A1
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 04:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3333B5373
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Mar 2025 03:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8052C1CAA7A;
	Tue, 18 Mar 2025 03:42:13 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C561C5F3A
	for <linux-ext4@vger.kernel.org>; Tue, 18 Mar 2025 03:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269333; cv=none; b=HOey8wwRJPLVNg0iDERqzfvnOUW85fVbMOAh9bY8hRgSpArIfq29E7oFIXCnQC6XMZ470Ty3m32aPGwylZaIxCis3QnvNVGvglroZ5kaePZmA1QcMypcWPUplua0gnqk9Mnd5jwpQNKswKXngLXDPTGDkunraUkwXT6W8efS4S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269333; c=relaxed/simple;
	bh=KxXiiRpdcj2qTFLPlX26QNgkeQEjYv4biOT4q5PE3+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yr8bc+9piQ6iszcDtLmLPd2IrvkYb61WhaHjlIq3CvBHFbXxVuqBHmY9rLcnmt0O9TBmnSbCiqc6CfnSYuq7iKbMnIwgPvq6xEqxUwPVg8EDP/gqF9pVHsJyIwJF/VrvEZ/DbMaETkdar3DEF6kj0keXAg4uSUFXQ0lfph/jpWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3fnK7012163
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:49 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id ECC7D2E0118; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: jack@suse.com, yi.zhang@huaweicloud.com,
        Kemeng Shi <shikemeng@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Minor cleanups to jbd2
Date: Mon, 17 Mar 2025 23:41:26 -0400
Message-ID: <174226639133.1025346.17805331764618272859.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250123155014.2097920-1-shikemeng@huaweicloud.com>
References: <20250123155014.2097920-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 23 Jan 2025 23:50:08 +0800, Kemeng Shi wrote:
> v1->v2:
> -Collect RVB from Jan and Yi.
> -Remove more stale comment in patch 4/6 as Yi suggested.
> 
> This series contains some random minor cleanups to jbd2. No funtional
> change is intended. More details can be found in respective patches.
> Thanks.
> 
> [...]

Applied, thanks!

[1/6] jbd2: remove unused h_jdata flag of handle
      commit: ec22493849247d60d595c93573ac3b01534b1965
[2/6] jbd2: remove unused return value of jbd2_journal_cancel_revoke
      commit: 9e6d3f9c8a85ed0db0ed1586049321e6b2ac5138
[3/6] jbd2: remove unused return value of do_readahead
      commit: 0d26708d8ec488da96a64eb1c6c47a8b3252edc5
[4/6] jbd2: remove stale comment of update_t_max_wait
      commit: 6c146277903f1826729bfb4817947d97a97b07cd
[5/6] jbd2: correct stale function name in comment
      commit: da5803391e377a39d655d55b4ebf2e416f88a8d6
[6/6] jbd2: Correct stale comment of release_buffer_page
      commit: fd3b3d7f51e628f54329738e736a154f6929daab

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

