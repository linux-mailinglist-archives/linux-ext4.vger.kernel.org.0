Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DD358DD92
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 20:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344163AbiHISAn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 14:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344129AbiHISAV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 14:00:21 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6C826549;
        Tue,  9 Aug 2022 10:59:59 -0700 (PDT)
Received: from letrec.thunk.org (c-24-1-67-28.hsd1.il.comcast.net [24.1.67.28])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 279HxVIU026650
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 Aug 2022 13:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1660067974; bh=BlpAqfIrf60T5Vg7k7izN/j7RQ2zSURc/Kjg71nTSn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=XuRJsKZHZvmvKXj+ONsAXiDqG9Hxh75O5AyHlvxHL+FCKlnpOGhMqPiiIlCxZK99Z
         LA/B2uBupuKBJhkjloEBRtGM96diUX2T1Y2qhJXLEPrILbwG9JUeHt8Y6YRFMMSko8
         u0qtmFjof1upAQl7LG6dRuc2voI6SdjGewBRgwxgytvO+LFcA6vQAGixbgURCQSzcq
         rrZIX2Ygh4njDC6Yjw3r04Q9unnZBjjDWFvYaru2CbN4laHRfeGfj1o0SJbhpBz2Lu
         izdJN+k3K4S1ythKzyYaT8VAvQu/NVaCZOdW7Zloqe5cOJWj934WquPVZaRddLqOQf
         d6d8HOCakVazA==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id D51E78C2DF2; Tue,  9 Aug 2022 13:59:30 -0400 (EDT)
Date:   Tue, 9 Aug 2022 13:59:30 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org,
        stable@kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Wang Jianjian <wangjianjian3@huawei.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.19] Documentation: ext4: fix cell spacing of table
 heading on blockmap table
Message-ID: <YvKggkBKw/jUb+SP@mit.edu>
References: <20220809080827.108363-1-bagasdotme@gmail.com>
 <YvJ3JPFQfzbhph89@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvJ3JPFQfzbhph89@magnolia>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Begas,

You sent me a patch to address this and it's fixed upstream, landing
in Linus's tree after 5.19 release during the current merge window.
It's cc'ed to stable@kernel.org, so it's not necessary for you to send
it to stable@ as a separate patch.

This upstream commit is 442ec1e5bb7c ("Documentation: ext4: fix cell
spacing of table heading on blockmap table").

					- Ted
