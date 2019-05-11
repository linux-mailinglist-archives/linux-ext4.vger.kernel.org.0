Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF3961A8A5
	for <lists+linux-ext4@lfdr.de>; Sat, 11 May 2019 19:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfEKRTo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 11 May 2019 13:19:44 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47196 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726787AbfEKRTn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 11 May 2019 13:19:43 -0400
Received: from callcc.thunk.org (rrcs-67-53-55-100.west.biz.rr.com [67.53.55.100])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4BHJauK030273
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 May 2019 13:19:38 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 51DC2420030; Fri, 10 May 2019 22:09:30 -0400 (EDT)
Date:   Fri, 10 May 2019 22:09:30 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Colin King <colin.king@canonical.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ext4: fix two cases where a u32 is being checked
 for a less than zero error return
Message-ID: <20190511020930.GG2534@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Colin King <colin.king@canonical.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190426220908.12790-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426220908.12790-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Apr 26, 2019 at 11:09:08PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are two cases where u32 variables n and err are being checked
> for less than zero error values, the checks is always false because
> the variables are not signed. Fix this by making the variables ints.
> 
> Addresses-Coverity: ("Unsigned compared against 0")
> Fixes: 345c0dbf3a30 ("ext4: protect journal inode's blocks using block_validity")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, applied.

					- Ted
