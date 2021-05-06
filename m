Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F9B375AC3
	for <lists+linux-ext4@lfdr.de>; Thu,  6 May 2021 20:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbhEFS7r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 May 2021 14:59:47 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21392 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhEFS7r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 May 2021 14:59:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620327524; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=DKFQo+TdVYSzQLKc2pe9zuGqvNIFet/cuZcjijUEn13DOndMrjTXkmpVX+sarr/23njm3aVKlEzk40Q9lXdgutdE4doYtd0uJtxj9CMNX90RpOcScx6GCeCPDPEqwUptCpGUP9teFNqVJ7lmzKCsocmxiISH+XGJ+k/Fi1Lvm6c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1620327524; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=UQxTdm3WU/SODKCa539VDrkQBD+lEolNiPXirKXM8EA=; 
        b=F0fOJxno/RL479ypt35m7z4yBybgwcrN5HF/d/gWQVGv7majlj59WO2nFzT6cJVcAYGZthbJyJVW3x1DUhtHPRt2EwYtCLPdROvPeyd5ChGocfiYP4uiV/zvdxaRFsDqm2XjsRYM0prgWliNdHpcN09/HwJmdy3MA4Qt+BPKGFI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com> header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1620327524;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=UQxTdm3WU/SODKCa539VDrkQBD+lEolNiPXirKXM8EA=;
        b=Gi9NGngB6HNtO+KBlNBrOpn5tHYL0L1rQgYN8bHoaSQ+imsLAxLJcyjCXI+8N1w4
        7x4wWOqY10RF+uoFcfet4y3/0DDRPgWiQfkuYnvjpk3u4kYzUw1ee9h67Gv6+pAobF1
        objUv1OHw0/x5HMRR3JFxS2YCmglvCTEX0Q1sIso=
Received: from anirudhrb.com (49.207.210.243 [49.207.210.243]) by mx.zohomail.com
        with SMTPS id 1620327523068162.41513027096732; Thu, 6 May 2021 11:58:43 -0700 (PDT)
Date:   Fri, 7 May 2021 00:28:35 +0530
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+2dcfeaf8cb49b05e8f1a@syzkaller.appspotmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix kernel infoleak via ext4_extent_header
Message-ID: <YJQ8WzDhqpCesoV4@anirudhrb.com>
References: <20210505133011.32484-1-mail@anirudhrb.com>
 <YJLFoFDJr00SJRqa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJLFoFDJr00SJRqa@gmail.com>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 05, 2021 at 09:19:44AM -0700, Eric Biggers wrote:
> On Wed, May 05, 2021 at 07:00:10PM +0530, Anirudh Rayabharam wrote:
> > Initialize eh_generation of struct ext4_extent_header to prevent leaking
> > info to userspace. Fixes KMSAN kernel-infoleak bug reported by syzbot at:
> > http://syzkaller.appspot.com/bug?id=78e9ad0e6952a3ca16e8234724b2fa92d041b9b8
> > 
> > Reported-by: syzbot+2dcfeaf8cb49b05e8f1a@syzkaller.appspotmail.com
> > Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> 
> Can you include a "Fixes:" tag?

Sent v2!

Thanks!

	- Anirudh.

> 
> - Eric
