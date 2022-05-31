Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93BF53934D
	for <lists+linux-ext4@lfdr.de>; Tue, 31 May 2022 16:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344664AbiEaOrq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 May 2022 10:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345313AbiEaOro (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 May 2022 10:47:44 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149E480232
        for <linux-ext4@vger.kernel.org>; Tue, 31 May 2022 07:47:40 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24VElYaM004741
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 10:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1654008455; bh=Ew2NCnOY35LDadZlDiMFS/DRn+pJH+BlZnLTC/Gsi9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NZWXsQL1ZjufMpwj1MG31ECXnE33OWW1MEcS1oJlf1UWbOsZJZL+nNotLnOFnCuvu
         UviW5HXcwK4l41kSPGaQIkGtosKbc0oPDBX53bT4cvWHqog9W3e22dIrUhN2ZzXapb
         +Qbo9msHlULNkboD3R34C31wKZqtNkU0czJ7DDvaTFqdNQnKjo4BCeP2HrudXVNq+5
         x5vKcjdTDeuTkO9zIHmD+wzRrkvNt7asYxRKk51cftaOBnM9zFpFXv3PSjYJkvm9Zw
         Nm0Pd5HKhgEA+9CFcq/i4LnRAZshrkRqh/ckyHIZQ7u5k7HHKZncSVVQ23ywXiJ4P7
         T6rmPaeYZqAsw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 506C615C3A95; Tue, 31 May 2022 10:47:34 -0400 (EDT)
Date:   Tue, 31 May 2022 10:47:34 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: the question about ext4 noacl mount option
Message-ID: <YpYqhq214oofeQAA@mit.edu>
References: <6258F7BB.8010104@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6258F7BB.8010104@fujitsu.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Apr 15, 2022 at 03:41:32AM +0000, xuyang2018.jy@fujitsu.com wrote:
> Hi Teo
> 
> When I use mount option noacl on 5.18-rc2, I got the following warning
> 
> [  179.441511] EXT4-fs: Mount option "noacl" will be removed by 3.5
>                Contact linux-ext4@vger.kernel.org if you think we should
> keep it.

I'm curious... is there a reason why you use noacl?  That is, if we
made the noacl mount option a no-op (that is, it wouldn't disable
Posix ACL's), would it make a difference for your use case?

      	      	       	    - Ted
