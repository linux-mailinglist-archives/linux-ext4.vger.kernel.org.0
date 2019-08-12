Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4306F8A870
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Aug 2019 22:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfHLUgM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Aug 2019 16:36:12 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37696 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726527AbfHLUgM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Aug 2019 16:36:12 -0400
Received: from callcc.thunk.org (guestnat-104-133-9-109.corp.google.com [104.133.9.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7CKa5qs030319
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 16:36:07 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6715F4218EF; Mon, 12 Aug 2019 16:36:05 -0400 (EDT)
Date:   Mon, 12 Aug 2019 16:36:05 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Colin King <colin.king@canonical.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: set error return correctly when
 ext4_htree_store_dirent fails
Message-ID: <20190812203605.GC28705@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Colin King <colin.king@canonical.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190805224419.24639-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805224419.24639-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 05, 2019 at 11:44:19PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently when the call to ext4_htree_store_dirent fails the error return
> variable 'ret' is is not being set to the error code and variable count is
> instead, hence the error code is not being returned.  Fix this by assigning
> ret to the error return code.
> 
> Addresses-Coverity: ("Unused value")
> Fixes: 8af0f0822797 ("ext4: fix readdir error in the case of inline_data+dir_index")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks.

					- Ted
