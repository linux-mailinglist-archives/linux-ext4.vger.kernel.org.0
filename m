Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2C2617D918
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 06:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgCIF4X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 01:56:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgCIF4X (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 9 Mar 2020 01:56:23 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8962E20674;
        Mon,  9 Mar 2020 05:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583733382;
        bh=foCcryb37oDraNojkaajgMrtHXqGJv5FpA7gpjZ1tDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GNjb5ez8K7rwS/HgZv/IMU8J5e16C8DkfGAJrcVpCmi+4Sh27NCENiYlsnkuQQsPw
         HUoNYrInZmurhu6Pv1ES4whUDHTHv270S/BSWjtqCqErlkVOmXXR3lz7e4e9GyUa7J
         sm8Xnmf/QtrtnCEjcd2mPhs1brYPKMsX0trNL50Y=
Date:   Sun, 8 Mar 2020 22:56:21 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cifs: clear PF_MEMALLOC before exiting demultiplex
 thread
Message-ID: <20200309055621.GA272474@sol.localdomain>
References: <20200308043645.1034870-1-ebiggers@kernel.org>
 <20200308061611.1185481-1-ebiggers@kernel.org>
 <CAH2r5mtRvs1NkWyvMvO1Pg2OPa9xq=gMUvHLgbA73bsj44DxVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mtRvs1NkWyvMvO1Pg2OPa9xq=gMUvHLgbA73bsj44DxVQ@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Mar 08, 2020 at 01:43:56PM -0500, Steve French wrote:
> merged into cifs-2.6.git for-next
> 
> running buildbot cifs/smb3 automated regression tests now
> 

Thanks.  FYI, I also sent a similar patch for an XFS kernel thread, and the XFS
folks requested more details in the commit message [1].  So I ended up trying to
reproduce this warning on both XFS and CIFS, and I added more details to both
commit messages.  So if it's not too late, please update the CIFS commit to the
v3 I'm sending out.  Thanks!

[1] https://lkml.kernel.org/linux-xfs/20200308230307.GM10776@dread.disaster.area

- Eric
