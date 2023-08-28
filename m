Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1862978B26A
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Aug 2023 16:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjH1OA6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Aug 2023 10:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjH1OAy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Aug 2023 10:00:54 -0400
Received: from mx.treblig.org (mx.treblig.org [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE328BA;
        Mon, 28 Aug 2023 07:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=vbDRtOVyo+nc5RTMfV+JT3H4Yd9qc1cB8kzq0DZ6Y10=; b=T2xOcDeh+GpCbwb0D8fFODzhwB
        aysuoA7MwDfh0bbGL1ijkotXr2s6owsn4HBbkGL/RgTZd2iavRgAHCOs1nnQ9mFxr0aKgN0VyzEvb
        6IwCyj7+12LslxBO2m2+NUHcLET55LAEsWN8cmRjIqVk6n7DgdD/vjy3rMhiikZTVGzjSnok4dp3/
        5DGiDwiisB7vP/8cukWkWtX549bSMaWduJedik+sz4oqULxNPr+pk0WOYO0CbAK34UmnVqEaJOBNy
        7WP9KQ5sI6qgzAhjeZcYvG15j62QC1b257Qp2rf/Rf6HVQkoDK+caKRlEmifv1Eg/DSF853ZvuG37
        ckPaRX8A==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qacnH-008vfM-5C; Mon, 28 Aug 2023 14:00:39 +0000
Date:   Mon, 28 Aug 2023 14:00:39 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, hch@lst.de,
        adilger.kernel@dilger.ca, song@kernel.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: 6.5.0rc5 fs hang - ext4? raid?
Message-ID: <ZOyoh9mhqvxDxOcb@gallifrey>
References: <ZNqWfQPTScJDkmpX@gallifrey>
 <20230815125146.GA1508930@mit.edu>
 <ZNt11WbPn7LCXPvB@gallifrey>
 <ZNu668KGiNcwCSVe@gallifrey>
 <ZNwm7Mo9yv7uIkno@gallifrey>
 <324fc71c-dead-4418-af81-6817e1f41c39@kernel.dk>
 <ZNzg1/zhxYV2EkBX@gallifrey>
 <ZNzl2Sq9UJ3FiTgV@gallifrey>
 <ZOymtgiZYGQ6QlxN@debian.me>
 <285df093-dd85-4d5f-8151-6d9f54a994b5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <285df093-dd85-4d5f-8151-6d9f54a994b5@kernel.dk>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 14:00:09 up 52 days, 23:31,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Jens Axboe (axboe@kernel.dk) wrote:
> On 8/28/23 7:52 AM, Bagas Sanjaya wrote:
> > On Wed, Aug 16, 2023 at 03:06:01PM +0000, Dr. David Alan Gilbert wrote:
> >>>> Can you try and pull in:
> >>>>
> >>>> https://git.kernel.dk/cgit/linux/commit/?h=block-6.5&id=5ff3213a5387e076af2b87f796f94b36965e8c3a
> >>>>
> >>>> and see if that helps?
> >>>
> >>> <testing....>
> >>
> >> Yes it seems to fix it - thanks!
> >>
> > 
> > #regzbot fix: 5ff3213a5387e076af2b87f796f94b36965e8c3a
> > 
> > Yet, I don't see that fix commit on v6.5 release...
> 
> That's because it's e5c0ca13659e9d18f53368d651ed7e6e433ec1cf

and it seems to be working nicely here (on rc7).

Dave

> -- 
> Jens Axboe
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
