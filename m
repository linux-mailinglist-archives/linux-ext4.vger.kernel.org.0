Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D59453895C
	for <lists+linux-ext4@lfdr.de>; Tue, 31 May 2022 02:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiEaA45 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 May 2022 20:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238350AbiEaA4z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 May 2022 20:56:55 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 539A613D2C
        for <linux-ext4@vger.kernel.org>; Mon, 30 May 2022 17:56:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 33B995344EA;
        Tue, 31 May 2022 10:56:49 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nvqBi-000oQ5-SC; Tue, 31 May 2022 10:56:46 +1000
Date:   Tue, 31 May 2022 10:56:46 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Stephen E. Baker" <baker.stephen.e@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-ext4@vger.kernel.org
Subject: Re: simplify ext4_sb_read_encoding regression
Message-ID: <20220531005646.GS3923443@dread.disaster.area>
References: <CAFDdnB38yRcZ+mQButh9UwGoh928xsZCgmjQ7r3HPEpEwdrZbg@mail.gmail.com>
 <87sfor85j1.fsf@collabora.com>
 <CAFDdnB3U67YJ7pivdHQaMB-CkdmvvTbcpxp1FXxBmFyAgJPknw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFDdnB3U67YJ7pivdHQaMB-CkdmvvTbcpxp1FXxBmFyAgJPknw@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=629567d2
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=QX4gbG5DAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=L6Xo-E_UR4rDp2-cLfoA:9 a=CjuIK1q_8ugA:10
        a=6Yrzetzbbx0A:10 a=t3fy0C-7FV0A:10 a=AbAUZ8qAyYyZVLSsDulk:22
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 30, 2022 at 06:27:29PM -0400, Stephen E. Baker wrote:
> On Mon, May 30, 2022 at 10:21 AM Gabriel Krisman Bertazi <krisman@collabora.com> wrote:
> > If that doesn't work, can you provide the kernel log?  If you can't
> > collect the console output, a photo of the screen displaying the error
> > will suffice.
> >
> I don't have any output to provide unfortunately. It fails before the
> backlight turns on, and nothing is written to disk. I seem to remember
> that someone else at Collabora had figured out a way to get a serial
> console on this device - perhaps Tomeu. I'm not equipped for that
> personally, particularly if it involves soldering.

https://www.kernel.org/doc/html/latest/networking/netconsole.html

-Dave.
-- 
Dave Chinner
david@fromorbit.com
