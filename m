Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CC0282145
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Oct 2020 06:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725648AbgJCEZv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Oct 2020 00:25:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44655 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725446AbgJCEZv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 3 Oct 2020 00:25:51 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0934OQsh026354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 3 Oct 2020 00:24:26 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1D8D542003C; Sat,  3 Oct 2020 00:24:26 -0400 (EDT)
Date:   Sat, 3 Oct 2020 00:24:26 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     =?utf-8?B?5bi45Yek5qWg?= <changfengnan@hikvision.com>,
        changfengnan <changfengnan@qq.com>,
        "adilger@dilger.ca" <adilger@dilger.ca>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "jack@suse.com" <jack@suse.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?= =?utf-8?B?5aSN?=
 =?utf-8?Q?=3A?= [PATCH] jbd2: avoid transaction reuse after reformatting
Message-ID: <20201003042426.GD23474@mit.edu>
References: <tencent_2341B065211F204FA07C3ADDA1AE07706405@qq.com>
 <20200911100603.GA26589@quack2.suse.cz>
 <2fa90e4995e0403f91f3290207618f35@hikvision.com>
 <20200917104440.GC16097@quack2.suse.cz>
 <6a08086d98c64f97bcaed1edd38861f6@hikvision.com>
 <20200918130252.GG18920@quack2.suse.cz>
 <708254ddee9b49d18ced1885dc7c29fa@hikvision.com>
 <20200923122435.GG6719@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200923122435.GG6719@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 23, 2020 at 02:24:35PM +0200, Jan Kara wrote:
> On Wed 23-09-20 06:29:12, 常凤楠 wrote:
> > The attachment is new patch.
> 
> Thanks!
> 
> > I have fix the logic in JBD2_REVOKE_BLOCK and JBD2_COMMIT_BLOCK case.
> > If the revoke block is the first block after valid transaction, I set the
> > flag like descriptor block ,and check it in commit block.  If the commit
> > block is the first block after valid transaction, I use ri_commit_block
> > to judge whether this commit block is next to another commit block, if so
> > it is illegal. I did't use time to judge commit block, because of the
> > possibility of time calibration, I think use ri_commit_block is more
> > reliable.
> 
> If the time is unreliable, your logic with ri_commit_block will detect only
> a small minority of the cases. The majority of cases will fail with
> checksum error. So I still don't think the ri_commit_block logic is really
> worth the additional code. Other than that the current version looks OK to
> me. So please do next submission with full changelog, Signed-off-by line,
> and the coding style issues fixed (you can use scripts/checkpatch.pl for
> patch verification). Thanks!

Hi changfengnan,

Have you had a chance to send a revised patch with the changes
requested by Jan?

Thanks,

					- Ted
