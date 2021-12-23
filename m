Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22CA47E5DA
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Dec 2021 16:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbhLWPnj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Dec 2021 10:43:39 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34566 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1349410AbhLWPmH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Dec 2021 10:42:07 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BNFfow6002088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 10:41:51 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2039E15C00C8; Thu, 23 Dec 2021 10:41:50 -0500 (EST)
Date:   Thu, 23 Dec 2021 10:41:50 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     yebin <yebin10@huawei.com>
Cc:     Lukas Czerner <lczerner@redhat.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next] ext4: Fix remount with 'abort' option isn't
 effective
Message-ID: <YcSYvk5DdGjjB9q/@mit.edu>
References: <20211221123214.2410593-1-yebin10@huawei.com>
 <20211221144305.nlryh7q2cgdbpmi5@work>
 <61C27A0E.9050900@huawei.com>
 <20211222091947.chmg6mcetocrmygd@work>
 <61C3D3CB.1010106@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61C3D3CB.1010106@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 23, 2021 at 09:41:31AM +0800, yebin wrote:
> 
> On 2021/12/22 17:19, Lukas Czerner wrote:
> > On Wed, Dec 22, 2021 at 09:06:22AM +0800, yebin wrote:
> > > 
> > > On 2021/12/21 22:43, Lukas Czerner wrote:
> > > > Hi,
> > > > 
> > > > nice catch. This is a bug indeed. However I am currently in a process of
> > > > changing the ctx_set/clear/test_ helpers because currently it generates
> > > > functions that are unused.
> > > > 
> > > > While I am at it I can just create a custom ctx_set_mount_flags()
> > > > helper that would behave as expected so that we won't have to specify
> > > > "1 < EXT4_MF_FS_ABORTED" which is not really obvious and hence error
> > > > prone.
> > > Actually, I fixed the first version as follows:
> > Allright, this looks better.

Was there an update to this patch?  I can't seem to find it in my
inbox or in patchwork....

Thanks,

					- Ted
