Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA5C13998D
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2020 20:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgAMTER (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Jan 2020 14:04:17 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50337 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726435AbgAMTER (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Jan 2020 14:04:17 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00DJ40cB023674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 14:04:01 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B6F314207DF; Mon, 13 Jan 2020 14:04:00 -0500 (EST)
Date:   Mon, 13 Jan 2020 14:04:00 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     zhengbin <zhengbin13@huawei.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH] ext4: use true,false for bool variable
Message-ID: <20200113190400.GE30418@mit.edu>
References: <1577241959-138695-1-git-send-email-zhengbin13@huawei.com>
 <20200109102254.GE27035@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109102254.GE27035@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 09, 2020 at 11:22:54AM +0100, Jan Kara wrote:
> On Wed 25-12-19 10:45:59, zhengbin wrote:
> > Fixes coccicheck warning:
> > 
> > fs/ext4/extents.c:5271:6-12: WARNING: Assignment of 0/1 to bool variable
> > fs/ext4/extents.c:5287:4-10: WARNING: Assignment of 0/1 to bool variable
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: zhengbin <zhengbin13@huawei.com>
> 
> Looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
