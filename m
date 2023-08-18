Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5525D78055E
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 07:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356121AbjHRFJ1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Aug 2023 01:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356615AbjHRFI1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Aug 2023 01:08:27 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A2B421C
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 22:07:51 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37I57XOH028114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 01:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692335257; bh=0mgpEzj5hI9J3ydCS18mKPuYugjTV/DjkKtv1Gng0U8=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=MKu5zM141EHxtFoLODEUi1w1BKj//ZZ+66AMJS8mGc4N/FXmxJvsirBgH4GWcdCo4
         1Ies8ax0nasR1hcDOcchf881kx//pxg95tB+JYtvJSogkIbupRMHqh4fc2Ca2p5k+h
         XhOLxN+0i0IQRwmc4v7EAPqilqiaLsOH/EJFYP6kOV4s2fErrPDMYlVSX0ucdOyaNc
         FUYeec6VplLv2EYVY1i+U8dpcBWQli1oVG5lOG8uyUZt9FpaHbJYVQW31A62Atpy4x
         PUoa1UfrBfxt8o374KvhSnQ5Ua4ddQGMuhd/6wnstSPY15P7jhpmXhHeru7mDAn6D6
         t8s172ZjbTM/g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A70B315C0501; Fri, 18 Aug 2023 01:07:33 -0400 (EDT)
Date:   Fri, 18 Aug 2023 01:07:33 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>, adilger.kernel@dilger.ca,
        ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 8/8] ext4: add first unit test for
 ext4_mb_new_blocks_simple in mballoc
Message-ID: <20230818050733.GH3464136@mit.edu>
References: <87jzucw5l7.fsf@doe.com>
 <fa68f2a4-e8f1-8856-0a99-736b70de0c52@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa68f2a4-e8f1-8856-0a99-736b70de0c52@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, it sounds like you are planning on a few additional changes to
this patch series, right?  When might you be planning on pushing out
the next version?

Thanks,

					- Ted
