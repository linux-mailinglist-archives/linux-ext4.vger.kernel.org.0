Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F63723D635
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Aug 2020 06:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgHFExv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Aug 2020 00:53:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44711 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727118AbgHFExu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Aug 2020 00:53:50 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0764rYov021458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Aug 2020 00:53:35 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AF651420263; Thu,  6 Aug 2020 00:53:34 -0400 (EDT)
Date:   Thu, 6 Aug 2020 00:53:34 -0400
From:   tytso@mit.edu
To:     zhengliang <zhengliang6@huawei.com>
Cc:     <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2] ext4: lost matching-pair of trace in ext4_truncate
Message-ID: <20200806045334.GD7657@mit.edu>
References: <20200701083027.45996-1-zhengliang6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701083027.45996-1-zhengliang6@huawei.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 01, 2020 at 04:30:27PM +0800, zhengliang wrote:
> It should call trace exit in all return path for ext4_truncate.
> 
> v2:
> It shoule call trace exit in all return path, and add "out_trace" label to avoid the
> multiple copies of the cleanup code in each error case.
>  
> Signed-off-by: zhengliang <zhengliang6@huawei.com>

Thanks, applied.

						- Ted
