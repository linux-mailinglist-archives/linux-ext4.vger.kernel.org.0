Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B191F49ADC0
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jan 2022 08:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447044AbiAYHqO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jan 2022 02:46:14 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:58607 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1446753AbiAYHna (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 25 Jan 2022 02:43:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V2pJgaO_1643096605;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0V2pJgaO_1643096605)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 Jan 2022 15:43:26 +0800
Date:   Tue, 25 Jan 2022 15:43:25 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        Zhang Yi <yi.zhang@huawei.com>, tytso@mit.edu,
        Jan Kara <jack@suse.cz>, chenlong <chenlongcl.chen@huawei.com>
Subject: Re: [RFC 0/1] ext4/054: Should we remove auto and quick group?
Message-ID: <20220125074325.GB12255@e18g06458.et15sqa>
References: <cover.1643089143.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1643089143.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 25, 2022 at 11:32:01AM +0530, Ritesh Harjani wrote:
> Hello Zhang/Ted,
> 
> Looks like the issue fixed by patches at [1], were observed with fault injection
> testing and with errors=continue mount option. But were not cc'd to stable.
> 
> Do you think those should be cc'd to stable tree?
> 
> Meanwhile, I was thinking we should anyway remove auto and quick group from this
> test as it could trigger a bug on in older kernel targets. Thoughts?

IMO, ext4/054 is a targeted regression test and should be in auto group,
which ensures the bug doesn't get re-introduced in future.

I think you could just skip this test to fit your kernel version, e.g.

echo ext4/054 > ext4.exclude
./check -X ext4.exclude

Thanks,
Eryu

> 
> 
> [1]: https://lore.kernel.org/all/20210908120850.4012324-1-yi.zhang@huawei.com/
> 
> Ritesh Harjani (1):
>   ext4/054: Remove auto and quick group
> 
>  tests/ext4/054 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --
> 2.31.1
