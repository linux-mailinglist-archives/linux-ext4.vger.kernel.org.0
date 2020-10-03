Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0D0282174
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Oct 2020 06:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgJCEzC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Oct 2020 00:55:02 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52330 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725446AbgJCEzC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 3 Oct 2020 00:55:02 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0934sebH014742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 3 Oct 2020 00:54:41 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5190042003C; Sat,  3 Oct 2020 00:54:40 -0400 (EDT)
Date:   Sat, 3 Oct 2020 00:54:40 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Qilong Zhang <zhangqilong3@huawei.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH -next] ext4: add trace exit in exception path.
Message-ID: <20201003045440.GG23474@mit.edu>
References: <20200921124738.23352-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921124738.23352-1-zhangqilong3@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 21, 2020 at 08:47:38PM +0800, Qilong Zhang wrote:
> From: Zhang Qilong <zhangqilong3@huawei.com>
> 
> Missing trace exit in exception path of ext4_sync_file and
> ext4_ind_map_blocks.
> 
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>

Thanks, applied.

					- Ted
