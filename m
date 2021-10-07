Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C4742583F
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Oct 2021 18:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbhJGQqd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 12:46:33 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35407 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242701AbhJGQqd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 12:46:33 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 197GiSI4024035
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Oct 2021 12:44:28 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 289C015C3E70; Thu,  7 Oct 2021 12:44:28 -0400 (EDT)
Date:   Thu, 7 Oct 2021 12:44:28 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yukuai3@huawei.com
Subject: Re: [RFC PATCH 1/3] ext4: check for out-of-order index extents in
 ext4_valid_extent_entries()
Message-ID: <YV8j7NDm+gsC5skt@mit.edu>
References: <20210908120850.4012324-1-yi.zhang@huawei.com>
 <20210908120850.4012324-2-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908120850.4012324-2-yi.zhang@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 08, 2021 at 08:08:48PM +0800, Zhang Yi wrote:
> After commit 5946d089379a ("ext4: check for overlapping extents in
> ext4_valid_extent_entries()"), we can check out the overlapping extent
> entry in leaf extent blocks. But the out-of-order extent entry in index
> extent blocks could also trigger bad things if the filesystem is
> inconsistent. So this patch add a check to figure out the out-of-order
> index extents and return error.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good,

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

