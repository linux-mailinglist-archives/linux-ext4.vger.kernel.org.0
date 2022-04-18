Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD0D505BE0
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Apr 2022 17:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345728AbiDRPvQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Apr 2022 11:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345790AbiDRPut (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Apr 2022 11:50:49 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8725710D3
        for <linux-ext4@vger.kernel.org>; Mon, 18 Apr 2022 08:28:56 -0700 (PDT)
Date:   Mon, 18 Apr 2022 15:28:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcgov.dev;
        s=protonmail; t=1650295732;
        bh=6VtwZ7x7FAVnYw98GdMmoY6xRsN8kIj8O+dOzs0mH0E=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=Aqb/mAu+bs/l+Y7kKd3HznB/3B40QjgJ3smIAXiTs027Ym5xdB6Hh4CMJiBl/bwNx
         bKfZ0IKotqgwxS9OGA8gm4Xs8U8w9JjXrlBEcnKdk9Kujah2lRcT8QFLR2rZX+0ru3
         Oa3QjcVfeCwUWgNsq7ZUO4XELIT30i34K+ygMcqtLLpGJdvNs0vFUMUzUMR/vdEeM7
         N24x18jvi87NSFUDa8AMmmJep2k2DrlVODBgiJMPh0i1RlCy62vxOg30nAtxdlJD0c
         q5r8yEdRtiBkWAKDIMJoEIMY32OhjxjUhOLIiFddEFaShEvvdbfb+7vXqE5MsIaadu
         sivbt6YA4ewbQ==
To:     "wangjianjian (C)" <wangjianjian3@huawei.com>,
        "Darrick J. Wong" <djwong@kernel.org>
From:   Matthew G McGovern <matthew@mcgov.dev>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Reply-To: Matthew G McGovern <matthew@mcgov.dev>
Subject: Re: [PATCH] Ext4 Documentation: ext4_xattr_header struct size fix
Message-ID: <4m3BihedqJrw4_Omv8MN6CHYpN0fmhyTmSlWY5b5_T3QdHx8DmHZz1CpUOIcEAAv7_HY0trjPocd8IWXI4WzHWO0RDKTVnQ8DfPwOcnexzo=@mcgov.dev>
In-Reply-To: <3815194d-9dfb-d5cb-db07-cd636aa80799@huawei.com>
References: <pvZcd0oHwCKt92jKr8OMUPT_Y9-UIziM36-74bg8vvEEOKgIW6_KiAdMKw7eRn5L8Tc4AKOSOOcaFmcVCAQ1TYM7gmYI0ZNmNqX_7tkqIE8=@mcgov.dev> <20220415013828.GA16986@magnolia> <3815194d-9dfb-d5cb-db07-cd636aa80799@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

However the fix gets into main is fine with me, it is not in the working tr=
ee or linux-next currently. Can someone commit to getting one of these patc=
hes in? This is my first submission so I'm not sure who needs to apply and =
submit exactly.

-mm


On Fri, Apr 15, 2022 at 6:07 PM, wangjianjian (C) <wangjianjian3@huawei.com=
> wrote:

> I submitted a similar patch fixed this and it should have already been
> in Ted's tree ?
