Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E253701A21
	for <lists+linux-ext4@lfdr.de>; Sat, 13 May 2023 23:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjEMVzf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 May 2023 17:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEMVze (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 13 May 2023 17:55:34 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A9C271C
        for <linux-ext4@vger.kernel.org>; Sat, 13 May 2023 14:55:32 -0700 (PDT)
Received: from letrec.thunk.org ([97.64.79.150])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34DLt7JI009505
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 May 2023 17:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1684014910; bh=1xs5zyw+s/I2FRuVFunqDdmfcHqGH1DvLR7tQJX8D3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=VP5C3NxdRjEhBgMVhJ7c6b12ZDpe1W2Aa3dKghaQ6tUiKDljri1nYA6hqyIsG+Uao
         lN845HVuEYBaVZGzGWc2WO7fV1fGIPaW0qIH7dmMr5tdKNbbPsjBHpfPmb1RnX+kJ3
         1VMOdpWBy9NkKFzOQ3R0K8stBzYMhttrOwdNMMJxQQ9U6T7ctUHdlzwejduc9zs1X3
         /JuzfqlBPiBEFNlQIYv9p0GK+c0jyCVC0zeNYsB3AXrJjHQH5yFYMzK6JQ1Qj8zBQk
         RYF5zlXiw4WEbfuRC7YMTaAan+jep0tnrKMRQm2KbJ5koyvJsQO5+MPvLi6JjaBs9m
         1nNoEmM3tswBQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 7C6D68C045A; Sat, 13 May 2023 17:55:07 -0400 (EDT)
Date:   Sat, 13 May 2023 17:55:07 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv1 0/4] ext4: misc left over folio changes
Message-ID: <ZGAHO2rwgR4ju3vd@mit.edu>
References: <cover.1681669004.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1681669004.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hey Ritesh,

My understanding is that you are intending on sending a revised
version of this patch set; is that correct?  Thanks!!

	   	      	      	   - Ted
