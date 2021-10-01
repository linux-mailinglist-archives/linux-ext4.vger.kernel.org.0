Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031B941EFDA
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Oct 2021 16:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354602AbhJAOoc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Oct 2021 10:44:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38700 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231679AbhJAOob (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Oct 2021 10:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633099367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2bbccypBfCl5grM4ulXy/1PBqbZWvw/APc7+0O/bpNI=;
        b=DR0lfw8+XcbWwnhsPLdXRNcjBavgDWM2/Ug4UWUXB6r10H0pdYLH6WMNoYGfE7V6q6BrAf
        6+w917lTTd+reKymaa9tAOGDFC8ylKPb1kgkJIiFvEVL0jfjCWCSlkndvUQoT38V1uMwW6
        /LqxNE8PQG8VviAvE0OJz7c/+LO+JJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-JGm3cxasMZqlTjXzgzYCDw-1; Fri, 01 Oct 2021 10:42:46 -0400
X-MC-Unique: JGm3cxasMZqlTjXzgzYCDw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23ECCDF8A6;
        Fri,  1 Oct 2021 14:42:45 +0000 (UTC)
Received: from work (unknown [10.40.194.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 026FC5F91D;
        Fri,  1 Oct 2021 14:42:43 +0000 (UTC)
Date:   Fri, 1 Oct 2021 16:42:39 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Alok Jain <jain.alok103@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: Issue with extension of ext4 filesystem on Rhel7
Message-ID: <20211001144239.fgizeucgzhingeio@work>
References: <CAG-6nk9DKKw2RHiXx_kWN1B5xcTrctTCypUPaicaaW1Ag0jDzw@mail.gmail.com>
 <81899623-90FE-4AFA-AAB6-5ABB21903CBB@dilger.ca>
 <YVcOqNktN4GgFFab@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVcOqNktN4GgFFab@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 01, 2021 at 09:35:36AM -0400, Theodore Ts'o wrote:
> On Thu, Sep 30, 2021 at 11:52:20PM -0600, Andreas Dilger wrote:
> > On Sep 30, 2021, at 23:43, Alok Jain <jain.alok103@gmail.com> wrote:
> > > 
> > > I have a problem while extending the ext4 filesystem on my block
> > > device which was 12Tb now extended to 32tb. I uses growpart then
> > > e2fsck followed by resize which failed, Any idea how to address
> > > this?
> > > 
> > > [root@prod-dev1 ~]# resize2fs /dev/sdj1
> > > 
> > > resize2fs 1.42.9 (28-Dec-2013)
> > > 
> > > resize2fs: New size too large to be expressed in 32 bits

Hi,

as others have already mentioned, unfortunatelly your file system does
not have 64-bit feature enabled and so you won't be able to simply
resize past 16TB. This feature was made default after RHEL7 GA, but sadly
it was likely too late for you, sorry about that.

You can try the advice given here, or you can contact RH support as they
might have some solution for you. However I am affraid it will always
involve backup for the reasons already mentioned.

> 
> Finally, in addtion to e2fsprogs 1.42.9 being Very, Very Old, if you
> are using such a prehistoric version of e2fsprogs, it's likely that
> the Linux kernel, and other portions of your Linux userspace, are
> antedeluvian as well.  That means not only are you missing bug fixes,
> you are likely missing many security bug fixes as well.

As I am sure you know RH is regularly fixing bugs and security bugs
especially and supporting RHEL releases for a very long time. As long as
10 years or even longer with ELS, that's much longer than say meager 3
years.

You can find more details here
https://access.redhat.com/support/policy/updates/errata/#Life_Cycle_Dates

-Lukas

