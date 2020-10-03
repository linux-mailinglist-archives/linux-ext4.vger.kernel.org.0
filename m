Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E549828218B
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Oct 2020 07:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725648AbgJCFT3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Oct 2020 01:19:29 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58877 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725446AbgJCFT2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 3 Oct 2020 01:19:28 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0935JOWQ031396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 3 Oct 2020 01:19:25 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C8F5D42003C; Sat,  3 Oct 2020 01:19:24 -0400 (EDT)
Date:   Sat, 3 Oct 2020 01:19:24 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Chunguang Xu <brookxu.cn@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: make mb_check_counter per group
Message-ID: <20201003051924.GN23474@mit.edu>
References: <1601292995-32205-1-git-send-email-brookxu@tencent.com>
 <1601292995-32205-2-git-send-email-brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601292995-32205-2-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 28, 2020 at 07:36:35PM +0800, Chunguang Xu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> Make bb_check_counter per group, so each group has the same chance
> to be checked, which can expose errors more easily.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Applied, thanks.

					- Ted
