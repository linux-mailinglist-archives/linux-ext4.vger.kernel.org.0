Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2374E28BBDE
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Oct 2020 17:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389975AbgJLP3Q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Oct 2020 11:29:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:47516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388984AbgJLP3Q (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 12 Oct 2020 11:29:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 418E2ACAC;
        Mon, 12 Oct 2020 15:29:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7D9401E12F5; Mon, 12 Oct 2020 17:29:13 +0200 (CEST)
Date:   Mon, 12 Oct 2020 17:29:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     =?utf-8?B?5bi45Yek5qWg?= <fengnanchang@foxmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Fengnan Chang <changfengnan@hikvision.com>
Subject: Re: [PATCH v4] jbd2: avoid transaction reuse after reformatting
Message-ID: <20201012152913.GI23665@quack2.suse.cz>
References: <20201007081319.16341-1-jack@suse.cz>
 <AF239FDD-1550-4D24-B2A4-C015689C9203@dilger.ca>
 <20201009021651.GI235506@mit.edu>
 <tencent_909C05B896D07CD8BC84F2EC74B03A1A4007@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_909C05B896D07CD8BC84F2EC74B03A1A4007@qq.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 09-10-20 19:06:41, 常凤楠 wrote:
> Hi Jan:
> Thank you for your suggestions，I tested the new version of
> the patch，I think there still have some prblems.  1. Looks
> like you think jbd2_has_feature_checksum can determine that CRC is
> enabled，but this is different from jbd2_journal_has_csum_v2or3. so when
> csum is v2 or v3, this is still have problem.  2. This patch
> looks fixed the situations of descriptor and revoke block, commit block
> is not considered. Maybe it’s because my previous modification was
> problematic，I have a new idea, how about check crc first and compare
> timestap,if check crc is failed, then compare timestap, this way the risk
> will be much smaller. What do you think?

Hum, you're right that commit block checking will not work with v2/v3
checksums. Thanks for catching that! I like the order of checks you propose
to fix the problem, I'll update the patch. Thanks!

								Honza

> ------------------&nbsp;Original&nbsp;------------------
> From:                                                                                                                        "Theodore Y. Ts'o"                                                                                    <tytso@mit.edu&gt;;
> Date:&nbsp;Fri, Oct 9, 2020 10:16 AM
> To:&nbsp;"Andreas Dilger"<adilger@dilger.ca&gt;;
> Cc:&nbsp;"Jan Kara"<jack@suse.cz&gt;;"linux-ext4"<linux-ext4@vger.kernel.org&gt;;"Fengnan Chang"<changfengnan@hikvision.com&gt;;"常凤楠"<fengnanchang@foxmail.com&gt;;
> Subject:&nbsp;Re: [PATCH v4] jbd2: avoid transaction reuse after reformatting
> 
> 
> 
> On Thu, Oct 08, 2020 at 02:13:02PM -0600, Andreas Dilger wrote:
> &gt; On Oct 7, 2020, at 2:13 AM, Jan Kara <jack@suse.cz&gt; wrote:
> &gt; &gt; 
> &gt; &gt; From: changfengnan <fengnanchang@foxmail.com&gt;
> &gt; &gt; 
> &gt; &gt; When ext4 is formatted with lazy_journal_init=1 and transactions from
> &gt; &gt; the previous filesystem are still on disk, it is possible that they are
> &gt; &gt; considered during a recovery after a crash. Because the checksum seed
> &gt; &gt; has changed, the CRC check will fail, and the journal recovery fails
> &gt; &gt; with checksum error although the journal is otherwise perfectly valid.
> &gt; &gt; Fix the problem by checking commit block time stamps to determine
> &gt; &gt; whether the data in the journal block is just stale or whether it is
> &gt; &gt; indeed corrupt.
> &gt; &gt; 
> &gt; &gt; Reported-by: kernel test robot <lkp@intel.com&gt;
> &gt; &gt; Signed-off-by: Fengnan Chang <changfengnan@hikvision.com&gt;
> &gt; &gt; Signed-off-by: Jan Kara <jack@suse.cz&gt;
> &gt; 
> &gt; Reviewed-by: Andreas Dilger <adilger@dilger.ca&gt;
> &gt; 
> &gt; NB: one trivial formatting cleanup if patch is refreshed
> &gt;
> 
> Applied, thanks.&nbsp; I fixed the trivial format cleanup you pointed out,
> plus a whitespace fix pointed out by checkpatch.
> 
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 	&nbsp;&nbsp;&nbsp;&nbsp; - Ted
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
