Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140B64AFBF8
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 19:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241029AbiBISv7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 13:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbiBISu5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 13:50:57 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7218C03E96E;
        Wed,  9 Feb 2022 10:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644432399; x=1675968399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/sf9RDeSLDsXwLAbDoDvwa7faj+vGk0nfM38INq+8DM=;
  b=dtU8cg14oWvUSx+8UWSnB8HX/0n/b6+ZF5C/XDpQrxspjo87W5zHBy+G
   0jhTkF8G27aHQ7Hqn+uskLBOJ9K/6eT/TkbROuFXd32XAr5gB0di5K1vz
   NXsEK0t659z7WnDTIxlq0GIy7pr1yongczUlGODt18TTlcyAv7qc7j4d0
   Q=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Feb 2022 10:46:39 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 10:46:38 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 10:46:38 -0800
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 9 Feb 2022
 10:46:36 -0800
Date:   Wed, 9 Feb 2022 13:46:34 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Jan Kara <jack@suse.cz>
CC:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        <linux-ext4@vger.kernel.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] jbd2: avoid __GFP_ZERO with SLAB_TYPESAFE_BY_RCU
Message-ID: <YgQMCoEM5/fSZpdo@qian>
References: <20220209165742.5659-1-quic_qiancai@quicinc.com>
 <20220209181010.gfn66rvip56i54df@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220209181010.gfn66rvip56i54df@quack3.lan>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 09, 2022 at 07:10:10PM +0100, Jan Kara wrote:
> On Wed 09-02-22 11:57:42, Qian Cai wrote:
> > Since the linux-next commit 120aa5e57479 (mm: Check for
> > SLAB_TYPESAFE_BY_RCU and __GFP_ZERO slab allocation), we will get a
> > boot warning. Avoid it by calling synchronize_rcu() before the zeroing.
> > 
> > Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
> 
> No, the performance impact of this would be just horrible. Can you
> ellaborate a bit why SLAB_TYPESAFE_BY_RCU + __GFP_ZERO is a problem and why
> synchronize_rcu() would be needed here before the memset() please? I mean
> how is zeroing here any different from the memory just being used?

I'll defer to Paul and other RCU developers for more indepth explanations of
the issue with the combo. The above mentioned commit has a bit information:

    Code using a SLAB_TYPESAFE_BY_RCU kmem_cache can have readers accessing
    blocks of memory passed to kmem_cache_free(), and those readers might
    still be accessing those blocks after kmem_cache_alloc() reallocates
    those blocks.  These readers are not going to take kindly to that memory
    being zeroed along the way.  Therefore, add a WARN_ON_ONCE() complaining
    about __GFP_ZERO being passed to an allocation from a SLAB_TYPESAFE_BY_RCU
    kmem_cache.
