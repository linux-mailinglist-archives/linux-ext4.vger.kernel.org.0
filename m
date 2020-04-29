Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495761BD2AA
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Apr 2020 04:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgD2CxI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 22:53:08 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:48139 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbgD2CxI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Apr 2020 22:53:08 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 3C7C5B63;
        Tue, 28 Apr 2020 22:53:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 28 Apr 2020 22:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        3bGEV+/NmxpXMqUYX149kUZqfmOq8oqQ2J1PZ7VwpYE=; b=z62TChVopEO7FtOZ
        vOUG1UAGKy5zSnnb9I0zlSzeQjQK1Dp9jLN1uvJRIxH4iO5EILOwQqkfog52qlYy
        6A6Qo5h17sKorhVY24JRXrcYjR/Q+LPNN313KeiVgsvJcIu2wbyxDCbDA3Vbf/lK
        WRHe0HVZjVT2qRra1Kmf714Ce1QZ1JL/9uMfJCr459d9Ua2aNDPDt2gDxirVRJaR
        rOWeLMXKk1U6+GWjIeOh87FGCOU//suYzbrN/aEU9VOCSiGL6IweDTZMR1yk+GM3
        hm4FoW4mgIasRiVomlPxIDWxwB12/8LfpwGNEOv1hLdhCJFDewLXFLPDLRAevm0O
        hCmisg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=3bGEV+/NmxpXMqUYX149kUZqfmOq8oqQ2J1PZ7Vwp
        YE=; b=hGx3XhQ26lUjQ0HOA7M1R2sUHbtIYVBuznUpuP/99HBM81koHwdtnGv4D
        kKH5k7Og6vTLOtlJyim1oVE9S66CzUxP09RVLjB/Lyiq5Us1yYqWOeBNzCewJ7kJ
        AaR6JkRFad4EC/aBqmFv7arnFMiC1eu+zXfTR6DEjoQolTFGbvTCx/vp6iiocXfX
        MG7Q4D4l3TpAFlI2vlowgRq1gyfNycPwQtWhhk13ZZ3vJBTxa88hykywYDv//Pqm
        m6HoSbeq79dDJqgjVkvRM1zYU+Ye4z59NLGGd+zv8E2zqagWg+3bbRXj8uiMarWS
        wrCy45UKcRl22mg7sZuxqMwcDpz5w==
X-ME-Sender: <xms:EuyoXsXm_LQ2ISgIz4nht6Czq3LmLwjErLSJTMEPQ1fDd5-u95ocJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedriedvgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdelrd
    duieehrdehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:EuyoXtZPTT2vfrVd9rtrorNjhOFbwQMmlqwcsng1JQNoVAUc7Eq2GA>
    <xmx:EuyoXknHloUrOB7Q497e1iA7yyHNuxx7_PqKtC5fRc8VStynVIs-ZQ>
    <xmx:EuyoXpfZKYrKzEuEJGuWOAxawWDmUmHY5tOS9uM64p1lzOSVS6RdWg>
    <xmx:EuyoXohzCRaEWmb63RReG4Id9ZD2B2HUovO0kTUX6-NWRchVfLIlng>
Received: from mickey.themaw.net (unknown [118.209.165.54])
        by mail.messagingengine.com (Postfix) with ESMTPA id 26A253065EDC;
        Tue, 28 Apr 2020 22:53:03 -0400 (EDT)
Message-ID: <4f6598e12127cc6e80af7dde5149220d92b07b11.camel@themaw.net>
Subject: Re: [PATCH v2 05/17] ext4: Allow sb to be NULL in ext4_msg()
From:   Ian Kent <raven@themaw.net>
To:     Lukas Czerner <lczerner@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-ext4@vger.kernel.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk
Date:   Wed, 29 Apr 2020 10:53:00 +0800
In-Reply-To: <20200428165747.ondq7nbn4ol3j3lu@work>
References: <20200428164536.462-1-lczerner@redhat.com>
         <20200428164536.462-6-lczerner@redhat.com>
         <20200428164808.GA3632@infradead.org>
         <20200428165747.ondq7nbn4ol3j3lu@work>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 2020-04-28 at 18:57 +0200, Lukas Czerner wrote:
> On Tue, Apr 28, 2020 at 09:48:08AM -0700, Christoph Hellwig wrote:
> > On Tue, Apr 28, 2020 at 06:45:24PM +0200, Lukas Czerner wrote:
> > > At the parsing phase of mount in the new mount api sb will not be
> > > available so allow sb to be NULL in ext4_msg and use that in
> > > handle_mount_opt().
> > > 
> > > Also change return value to appropriate -EINVAL where needed.
> > 
> > Shouldn't mount-time messages be reported using the logfc and
> > family
> > helpers from include/linux/fs_context.h? (which btw, have really
> > horrible over-generic names).
> 
> I am sure it should at some point, but I am not really sure how ready
> it is at the moment. Last time I checked David told me not to bother
> using it yet.
> 
> Is it ready yet David ? Should we be switching to it ?

The mount-API log macros tend to cause user confusion because they
often lead to unexpected log messages.

We're seeing that now with bugs logged due to unexpected messages
resulting from the NFS mount-API conversion.

I'd recommend mostly avoiding using the macros until there's been
time to reconsider how they should work, after all fsopen() and
friends will still get errno errors just not the passed string
description.

Ian

