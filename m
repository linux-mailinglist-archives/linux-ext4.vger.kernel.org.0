Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427363B1200
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jun 2021 05:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhFWDI1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Jun 2021 23:08:27 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58786 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229774AbhFWDI1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Jun 2021 23:08:27 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15N362U4026019
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 23:06:02 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1375015C3CD6; Tue, 22 Jun 2021 23:06:02 -0400 (EDT)
Date:   Tue, 22 Jun 2021 23:06:02 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lishujin@kuaishou.com
Subject: Re: [PATCH V2 5/7] ext4: get buddy cache after insert successfully
Message-ID: <YNKlGn3GRFCtyls7@mit.edu>
References: <164ffa3b-c4d5-6967-feba-b972995a6dfb@gmail.com>
 <a602a6ba-2073-8384-4c8f-d669ee25c065@gmail.com>
 <49382052-6238-f1fb-40d1-b6b801b39ff7@gmail.com>
 <48e33dea-d15e-f211-0191-e01bd3eb17b3@gmail.com>
 <67eeb65a-d413-c4f9-c06f-d5dcceca0e4f@gmail.com>
 <93458049-0d43-617a-a5e7-c7e10325443a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93458049-0d43-617a-a5e7-c7e10325443a@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 26, 2021 at 04:43:43PM +0800, Wang Jianchao wrote:
> The getting of bd_bitmap_page and bd_buddy_page should be done
> after insert the ext4_free_data successfully. Otherwise, nobody
> can put them.
> 
> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>

This looks like it's a bug fix for patch 4/7 --- is that correct?  If
so, maybe we should fold this into the previous patch?

Thanks,

						- Ted
