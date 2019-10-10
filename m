Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC38DD2077
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Oct 2019 07:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbfJJFo0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Oct 2019 01:44:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43326 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732800AbfJJFoZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Oct 2019 01:44:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id f21so2214214plj.10
        for <linux-ext4@vger.kernel.org>; Wed, 09 Oct 2019 22:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d/oe2s886bN8qUzvhOLB+CA2L54j/Xxt6d1BIgZPIoA=;
        b=ZRpjEgoyCHF9AX4rOp1AfD51SpFfwb9VH9ahLOQASNF5SAYpXOHmUbpR+gZ3LrB+tn
         E4W1SVv5rsnVMmqxdE6QeWFVma16JzdgJ2kkK/eiG4Nzj5q0KV9wQRhsEg9v37b2JtH6
         QZ2JEfvQZG0JD/VyQFlt+v5Racvf0rCwJz114qO9BKSSnSof/fafgvN4qIgesLUQjI9j
         zd2AImQzXzNAjDcthlKyxTbZQiWRUIGRqjvLA9/NrISGGOSZxdR1lOSjTmp5KB8F33dG
         eum7VL5V5Hp4s+ITgOOav2FB1GrmNGEMslz62w6e6c19mQoV13/zQGKXL/18N1CE+PHg
         bRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d/oe2s886bN8qUzvhOLB+CA2L54j/Xxt6d1BIgZPIoA=;
        b=KkYqre4dyRCqHsJaE0Zea8mdTFuNXFzan4i1sjXRZpcl3PNHW8MchG6TZQyQGpSzD5
         jGBW1koLge+/EJ4vY6GqYmL/rv0HZ6UyZD0zW2EjKDI9/Uh/UCFLWKkFU3lEZGoBA+rz
         eGESYpB3PjlkgQRc7YhHtGhwL2vdn6YS1trYySd88PTXT/He3paYSBCfZwzz27esWbBn
         NSOGR3ZwHqv30C1NjUyx67gKSEQa2EfoIn4PePiiJMNwbFrCJ0LC/7qDThv2QrmGEyrN
         TpozeSwwCjhx9j1a++EiXEcelibZlHOd5XqTVmQCetvzM/GeAI75fYn1UpfNkSZGRMm0
         jqSQ==
X-Gm-Message-State: APjAAAXpKh0LOM1fIgAHy1hVfltlk7x1wTq0UmuYiBFgJr/phOFLmVdD
        6JCtGoneBxFWfIcAHO2DVFAwjnVoAUmA
X-Google-Smtp-Source: APXvYqyPus+Zo06gqbrvszqPbaJI+dLKsCTfEyk+bXQQ1XprdU5BzFHkhWA51miYMdMyamN23X/KzA==
X-Received: by 2002:a17:902:8e81:: with SMTP id bg1mr7463619plb.137.1570686265003;
        Wed, 09 Oct 2019 22:44:25 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id g7sm5680732pfm.176.2019.10.09.22.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 22:44:24 -0700 (PDT)
Date:   Thu, 10 Oct 2019 16:44:18 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 5/8] ext4: move inode extension/truncate code out from
 ->iomap_end() callback
Message-ID: <20191010054418.GD19064@bobrowski>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <da556191f9dba2b477cce57665ded57bfd396463.1570100361.git.mbobrowski@mbobrowski.org>
 <20191008112512.GH5078@quack2.suse.cz>
 <20191009101848.GG2125@poseidon.bobrowski.net>
 <20191009125132.GC5050@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009125132.GC5050@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 09, 2019 at 02:51:32PM +0200, Jan Kara wrote:
> On Wed 09-10-19 21:18:50, Matthew Bobrowski wrote:
> > > Just small nits below:
> > > 
> > > > +static int ext4_handle_inode_extension(struct inode *inode, loff_t offset,
> > > > +				       ssize_t written, size_t count)
> > > > +{
> > > > +	int ret = 0;
> > > 
> > > I think both the function and callsites may be slightly simpler if you let
> > > the function return 'written' or error (not 0 or error). But I'll leave
> > > that decision upto you.
> > 
> > Hm, don't we actually need to return 0 for success cases so that
> > iomap_dio_complete() behaves correctly i.e. increments iocb->ki_pos,
> > etc?
> 
> Correct, iomap_dio_complete() expects 0 on success. So if we keep calling
> ext4_handle_inode_extension() from ->end_io handler, we'd need some
> specialcasing there and I agree that changing ext4_handle_inode_extension()
> return convention isn't then very beneficial. If we stop calling
> ext4_handle_inode_extension() from ->end_io handler (patch 8/8 discussion
> pending), then the change would be a clear win.

Agreed. Well, I think we've got some movement in the right direction in 8/8,
so it looks like changing up the return values is what we'll go ahead with.

--<M>--
