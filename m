Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B013ABD5B
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jun 2021 22:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhFQUXX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Jun 2021 16:23:23 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45340 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232382AbhFQUXW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Jun 2021 16:23:22 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15HKL6px011740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Jun 2021 16:21:07 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BB03015C3CBA; Thu, 17 Jun 2021 16:21:06 -0400 (EDT)
Date:   Thu, 17 Jun 2021 16:21:06 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Pan Dong <pandong.peter@bytedance.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: fix avefreec in find_group_orlov
Message-ID: <YMuusnoh/aFe97Lt@mit.edu>
References: <20210525073656.31594-1-pandong.peter@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525073656.31594-1-pandong.peter@bytedance.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 25, 2021 at 03:36:56PM +0800, Pan Dong wrote:
> The avefreec should be average free clusters instead
> of average free blocks, otherwize Orlov's allocator
> will not work properly when bigalloc enabled.
> 
> Signed-off-by: Pan Dong <pandong.peter@bytedance.com>

Applied, thanks.

				- Ted
