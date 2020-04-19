Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4B01AF6D5
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Apr 2020 06:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgDSEma (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Apr 2020 00:42:30 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40341 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725763AbgDSEma (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Apr 2020 00:42:30 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03J4gO9Z020836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Apr 2020 00:42:25 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A630242013B; Sun, 19 Apr 2020 00:42:24 -0400 (EDT)
Date:   Sun, 19 Apr 2020 00:42:24 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: validate fiemap iomap begin offset and length value
Message-ID: <20200419044224.GA311394@mit.edu>
References: <20200418233231.z767yvfiupy7hwgp@xzhoux.usersys.redhat.com>
 <20200419015654.F2061A4051@d06av23.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419015654.F2061A4051@d06av23.portsmouth.uk.ibm.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Apr 19, 2020 at 07:26:53AM +0530, Ritesh Harjani wrote:
> ++ mailing list.
> Sorry somehow it got dropped.
> 
> 
> On 4/19/20 7:21 AM, Ritesh Harjani wrote:
> > Hello Murphy,
> > 
> > I guess the patch to fix this issue was recently submitted.
> > Could you please test your reproducer, xfstest and ltp
> > tests on below patch too. And let me know if we can add your Tested-by:
> > 
> > https://patchwork.ozlabs.org/project/linux-ext4/patch/1a2dc8f198e1225ddd40833de76b60c7ee20d22d.1587024137.git.riteshh@linux.ibm.com/

His reproducer is still failing with your patch.  In order to for his
reproducer to succeed, we need to constrain lblk and last_lblk more
strictly than what is done in:

[PATCHv2 1/1] ext4: fix overflow case for map.m_len in ext4_iomap_begin_*

His patch does fix the issue.

ext4_map_block() is returning EFSCORRUPTED when lblk is
EXT4_MAX_LOGICAL_BLOCK, which is why he's constraining lblk to
EXT4_MAX_LOGICAL_BLOCK.  I haven't looked into this more closely yet,
but it looks we have some overflow/wraparound issue when lblk is
0xFFFFFFFF.  Which might mean that in fact EXT4_MAX_LOGICAL_BLOCK
might need to be 0xFFFFFFFE, or we need to look very closely our code
paths to make sure the right thing happes when we call
ext4_map_blocks() with m_lblk == 0xFFFFFFFF and m_len == 1.

I think we need to take his patch, and make a simialr change to
ext4_iomap_begin().   Ritesh, do you agree?

						- Ted
							
