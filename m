Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B31DFA6B
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2019 04:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbfJVB6m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Oct 2019 21:58:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43094 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfJVB6m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Oct 2019 21:58:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id l24so4013858pgh.10
        for <linux-ext4@vger.kernel.org>; Mon, 21 Oct 2019 18:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ot/px8XAvgp2k4Y12zJFTxEco31g9YFn1T6HKU1iFrE=;
        b=oMKguG/ZYHhfLtn8kf8xUd4Jbz6d0iHm0g3U6wbFf1TokrLZMEz1QRkj7J2CM/eD1Z
         phOijuSuHGHliPSIvTQ/Nkl0fKXW3PuyzcjjdUv4xirbcJpdjYe5ZYjkmQkNRpW12v0X
         x5Ifz2OuLnCUQlIlBlIye6aB8Nf1zcQ4F7JzQwNfPIcHsdHwBTkuxvDPMZqcx+dTx2gV
         ZrBiyl2T/I7cF+cbfd8tdv0vXXr0wrXl+i8W1BmsyvdTF7EkxeZf71pVYw72k/itltiq
         kYaCAe9bddksq+Fzewm9MbjxB4fpKnvOywxLXcRQWt28dKGM/O7yMu5Q8aeqirC6SmVP
         gvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ot/px8XAvgp2k4Y12zJFTxEco31g9YFn1T6HKU1iFrE=;
        b=edbMDe+0WL56FHV2Cjgw2TgRxFA8XVq+EAKrqCndSHL2fkTi+0Y+hqQh3o1Lbtyy9p
         IPgKJZph84QHSOpZtFi5JeiL9oBgPdmfmhzhplIKp1EMy+9M0uVLWuNai6y5wLlIsJXf
         DoK+hLKq1kgCb4Q01XVrTz86fISrilDGyIq5kCQ9VRrjseFEevtsJMbAQSh8k1uw5LLf
         xxPp/Qq5ZYKl4DOsQ8VQR6FAxXqjmRLu7NJ1eIwJPPjHNtcH5gCk4eGzvjy83we1Me52
         WMEjqBq7+xOgRv6rQf/pVXGYvzx3/qgtOxxsavRsCLRITKkld3np+qOlZF03y8ovv0VN
         Qa7Q==
X-Gm-Message-State: APjAAAUaLoSv5Yh69IjIb/fKaTosohNDiczDRLUS3DUSA/B89Gj9BTeT
        Gr4Q7OxLAqJsN7yTT0wPKy8f
X-Google-Smtp-Source: APXvYqynliDSFtplvBI+UibC5ybCW5IEI0HWbVgSi5OOU69eFze1mVM+3a/YOWXOmYJY8NF6bJWJQg==
X-Received: by 2002:aa7:9907:: with SMTP id z7mr1253810pff.133.1571709521277;
        Mon, 21 Oct 2019 18:58:41 -0700 (PDT)
Received: from athena.bobrowski.net (n1-41-199-60.bla2.nsw.optusnet.com.au. [1.41.199.60])
        by smtp.gmail.com with ESMTPSA id a13sm20575566pfg.10.2019.10.21.18.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 18:58:40 -0700 (PDT)
Date:   Tue, 22 Oct 2019 12:58:34 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 07/12] ext4: introduce direct I/O read using iomap
 infrastructure
Message-ID: <20191022015834.GD5092@athena.bobrowski.net>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <280de880787dc7c064c309efb685f95d4ff732a9.1571647179.git.mbobrowski@mbobrowski.org>
 <20191021134131.GF25184@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021134131.GF25184@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 21, 2019 at 03:41:31PM +0200, Jan Kara wrote:
> On Mon 21-10-19 20:18:37, Matthew Bobrowski wrote:
> > This patch introduces a new direct I/O read path which makes use of
> > the iomap infrastructure.
> > 
> > The new function ext4_do_read_iter() is responsible for calling into
> > the iomap infrastructure via iomap_dio_rw(). If the read operation
> > performed on the inode is not supported, which is checked via
> > ext4_dio_supported(), then we simply fallback and complete the I/O
> > using buffered I/O.
> > 
> > Existing direct I/O read code path has been removed, as it is no
> > longer required.
> > 
> > Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> 
> Looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> BTW, I think I gave you my Reviewed-by tag for this patch also last time
> and this patch didn't change since then. You can just include the tag in
> your posting in that case.

The lock pattern was dropped here, so I thought I'd just have you
review it again to be sure that you didn't object. But anyway, thank
you!

--<M>--
