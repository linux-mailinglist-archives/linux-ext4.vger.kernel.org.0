Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA3B77EE5D
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Aug 2023 02:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347345AbjHQAhx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Aug 2023 20:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347439AbjHQAhZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Aug 2023 20:37:25 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5E52D58
        for <linux-ext4@vger.kernel.org>; Wed, 16 Aug 2023 17:37:15 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B034650131D
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 00:37:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a310.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4E284501302
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 00:37:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1692232631; a=rsa-sha256;
        cv=none;
        b=f4hW7MTd9Seb9s9OgejVzhvaLEqMJYAdvnf998GcrLj7NFpO3bV73cCwFR345YdmBXK/oQ
        vIyHgkiZoyjtm0GgABFNq2ruU/9kF0YrVwiiAH12YEbQRERjBJksnJXusSzNgI41E+3rhv
        x7iCd7w6PguQAbQ3XDUZFXsilLGS2YRknJ/I7wOgrBjuBo93vD2OV12muA4L22XVhsWcmx
        zVeg8+HYKLzEvSLRQUQyyro3e6gpTBjQ3XE0VkzRuLi9llhwYCc1KD1b/yBy6MqipgJbLQ
        TclBKg+vNkOFmD5fmd95rpLnsTXw7Nuj9eJ5ahEMtx6g5bZq3izgyk4fLnexjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1692232631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=d5q6jsf40IHiPMVWSY+QhuXA644QLn34um8tp3Ek9kM=;
        b=5cLVNZs08Vlq+4xySCGB2rECJbz7854ukdGjfCp1dxGXaqYZcAWCTuJA+lPcDM5ju6yZyd
        lZw19bRaDcPr969SpntaiptfbxA5PSz2qiVY6T5V6KKAmWkHzviAZO8SLZh7Xz0MluCObq
        09hHPq3U7Z964IBFcS045DdSLnx6MOXE6ZhV9waacfasBeBbIzXhRJejcmxJOkaIEwsn/V
        DwBXnHvL04aDkvMQ7UmDpJnDqAxWyAxb0bxzUHxnBbr67IFZmeINKRrKKekIn8SAcdZZho
        klzJMZwHneUM8j92Krh1XdObPEJ7xaWKNqehfM7KMEN+sPQFJCfqccPOzD70bg==
ARC-Authentication-Results: i=1;
        rspamd-849d547c58-pvjt6;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Trail-Wipe: 29cc9131048a0d3a_1692232631529_603113008
X-MC-Loop-Signature: 1692232631529:2557787218
X-MC-Ingress-Time: 1692232631528
Received: from pdx1-sub0-mail-a310.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.110.206.19 (trex/6.9.1);
        Thu, 17 Aug 2023 00:37:11 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a310.dreamhost.com (Postfix) with ESMTPSA id 4RR5gC0Yv8z6n
        for <linux-ext4@vger.kernel.org>; Wed, 16 Aug 2023 17:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1692232631;
        bh=d5q6jsf40IHiPMVWSY+QhuXA644QLn34um8tp3Ek9kM=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=ciYy+huWFtkWRceLVZHweLVvy2kNzoAuvVxQAlFvW6fF4BrWR1VfWnqdiHsfsu+gz
         fZyg4WuLVYzhZm6KfZlXjo72juFdY/xZURkTUjlf02EyCPAOkWdatpmcNHiQOxEdoz
         bbw4V729wblQzM2cA07sx4JpWBdgrPwlox4OHoc42+yW6NFMGNWuz7HbGuVx24gTlb
         1QsdWYhqfKIbYxHOn3jV6ue+KvheCyGWd84VkHZilirVDbf7yxeBLb3zggon9kRsQ7
         hIA6IYA2pI/qJm9z8nYLn6mJ02auMf34P4dwU4DudThBbc00EsX58G/XXQl/ny2z9W
         /6OVUyz54HQxg==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0058
        by kmjvbox (DragonFly Mail Agent v0.12);
        Wed, 16 Aug 2023 17:37:05 -0700
Date:   Wed, 16 Aug 2023 17:37:05 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [e2fsprogs PATCH] resize2fs: use directio when reading superblock
Message-ID: <20230817003705.GB1980@templeofstupid.com>
References: <20230605225221.GA5737@templeofstupid.com>
 <20230607133909.GA1309044@mit.edu>
 <20230607185041.GA2023@templeofstupid.com>
 <20230609042239.GA1436857@mit.edu>
 <20230610021131.GA6134@templeofstupid.com>
 <20230628230220.GA1918@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628230220.GA1918@templeofstupid.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

On Wed, Jun 28, 2023 at 04:02:20PM -0700, Krister Johansen wrote:
> Hi Ted,
> 
> On Fri, Jun 09, 2023 at 07:11:31PM -0700, Krister Johansen wrote:
> > On Fri, Jun 09, 2023 at 12:22:39AM -0400, Theodore Ts'o wrote:
> > > As far as your patch is concerned, resize2fs can do both off-line
> > > (unmounted) and on-line (mounted) resizes.  And turning direct I/O
> > > unconditionally isn't a great idea for off-line resizes --- it will
> > > really trash the performance of the resize.
> > 
> > Thanks for the additional detail.
> > 
> > I also double-checked to make sure these systems had the following patch
> > applied:
> > 
> > 05c2c00f3769 ext4: protect superblock modifications with a buffer lock
> > 
> > And they do.  Not sure if that's directly applicable to the online
> > resize case though.
> > 
> > > Does this patch work for you instead?
> > 
> > Thanks, it does!
> > 
> > > diff --git a/resize/main.c b/resize/main.c
> > > index 94f5ec6d..f914c050 100644
> > > --- a/resize/main.c
> > > +++ b/resize/main.c
> > > @@ -409,6 +409,8 @@ int main (int argc, char ** argv)
> > >  
> > >  	if (!(mount_flags & EXT2_MF_MOUNTED) && !print_min_size)
> > >  		io_flags = EXT2_FLAG_RW | EXT2_FLAG_EXCLUSIVE;
> > > +	if (mount_flags & EXT2_MF_MOUNTED)
> > > +		io_flags |= EXT2_FLAG_DIRECT_IO;
> > >  
> > >  	io_flags |= EXT2_FLAG_64BITS | EXT2_FLAG_THREADS;
> > >  	if (undo_file) {
> > 
> > If it counts:
> > 
> > Reviewed-by: Krister Johansen <kjlx@templeofstupid.com>
> > Tested-by: Krister Johansen <kjlx@templeofstupid.com>
> 
> Just wanted to check back on this.  Should I send a v2 that incorporates
> the changes you suggested above?

I've been running this patch on our production systems for the past
couple of months and haven't had any re-occurence of the bad superblock
checksum error.  It used to occur a few times a day.

Is there anything more I can do to help get this accepted into
e2fsprogs?

Thanks very much,

-K
