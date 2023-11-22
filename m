Return-Path: <linux-ext4+bounces-81-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FED07F474D
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Nov 2023 14:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDDBD1C20336
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Nov 2023 13:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE6B4C62B;
	Wed, 22 Nov 2023 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BE5193
	for <linux-ext4@vger.kernel.org>; Wed, 22 Nov 2023 05:02:51 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Sb1Xm2Fk1z1P8fl;
	Wed, 22 Nov 2023 20:59:20 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 22 Nov 2023 21:02:48 +0800
Subject: Re: [PATCH 0/5] jbd2: Add errseq to detect writeback
To: Zhihao Cheng <chengzhihao1@huawei.com>, <tytso@mit.edu>, <jack@suse.com>
CC: <linux-ext4@vger.kernel.org>
References: <20231103145250.2995746-1-chengzhihao1@huawei.com>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <1d45466e-44e2-5be4-d2be-f7339dd4b5b7@huawei.com>
Date: Wed, 22 Nov 2023 21:02:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231103145250.2995746-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected

For series.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

On 2023/11/3 22:52, Zhihao Cheng wrote:
> According to discussions in [1], this patchset adds errseq in journal to
> enable JDB2 detecting meatadata writeback error of fs dev. Then, orginal
> checking mechanism could be removed.
> 
> [1] https://lore.kernel.org/all/20230908124317.2955345-1-chengzhihao1@huawei.com/T/
> 
> Zhihao Cheng (5):
>   jbd2: Add errseq to detect client fs's bdev writeback error
>   jbd2: Replace journal state flag by checking errseq
>   jbd2: Remove unused 'JBD2_CHECKPOINT_IO_ERROR' and 'j_atomic_flags'
>   jbd2: Abort journal when detecting metadata writeback error of fs dev
>   ext4: Move ext4_check_bdev_write_error() into nojournal mode
> 
>  fs/ext4/ext4_jbd2.c   |  5 ++---
>  fs/jbd2/checkpoint.c  | 11 -----------
>  fs/jbd2/journal.c     | 11 ++++++-----
>  fs/jbd2/recovery.c    |  7 +------
>  fs/jbd2/transaction.c | 14 ++++++++++++++
>  include/linux/jbd2.h  | 37 ++++++++++++++++++++++++++-----------
>  6 files changed, 49 insertions(+), 36 deletions(-)
> 

