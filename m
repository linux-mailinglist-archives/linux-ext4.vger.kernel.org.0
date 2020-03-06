Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70F5417C644
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2020 20:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgCFTZF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Mar 2020 14:25:05 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58078 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbgCFTZF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Mar 2020 14:25:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 55B8A8EE11D;
        Fri,  6 Mar 2020 11:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583522704;
        bh=uVWbr0sqmC6Bb+PI/aDoieyYYNanyXUlEte94lPWyXE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TAjRKxCHcV6+2WRh7M29+WjXLosknEBZBPU9UOSQqo3d249iIoBMU0uVPfrBFo0ao
         u/aoixVaQfyHS0CoVJiE3+Sy97ml9+0H5cY4mO5SQIP1EHpcrdbSUShTav/lID3+7x
         bUw3w4Gflw03KyeqYWl4wZW5aWuq3GcexyRQhhl0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LcvSHL7VW-6A; Fri,  6 Mar 2020 11:25:04 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 938658EE0F8;
        Fri,  6 Mar 2020 11:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583522704;
        bh=uVWbr0sqmC6Bb+PI/aDoieyYYNanyXUlEte94lPWyXE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TAjRKxCHcV6+2WRh7M29+WjXLosknEBZBPU9UOSQqo3d249iIoBMU0uVPfrBFo0ao
         u/aoixVaQfyHS0CoVJiE3+Sy97ml9+0H5cY4mO5SQIP1EHpcrdbSUShTav/lID3+7x
         bUw3w4Gflw03KyeqYWl4wZW5aWuq3GcexyRQhhl0=
Message-ID: <1583522702.3653.86.camel@HansenPartnership.com>
Subject: Re: [LSFMMBPF TOPIC] Killing LSFMMBPF
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Date:   Fri, 06 Mar 2020 11:25:02 -0800
In-Reply-To: <20200306182302.GA31215@bombadil.infradead.org>
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
         <20200306160548.GB25710@bombadil.infradead.org>
         <1583516279.3653.71.camel@HansenPartnership.com>
         <20200306182302.GA31215@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 2020-03-06 at 10:23 -0800, Matthew Wilcox wrote:
> On Fri, Mar 06, 2020 at 09:37:59AM -0800, James Bottomley wrote:
> > Can I just inject a dose of reality here:  The most costly thing is
> > Venue rental (which comes with a F&B minimum) and the continuous
> > Tea and Coffee.  Last year for Plumbers, the venue cost us $37k and
> > the breaks $132k (including a lunch buffet, which was a requirement
> > of the venue rental).  Given we had 500 attendees, that, alone is
> > $340 per head already.  Now we could cut out the continuous tea and
> > coffee ... and the espresso machines you all raved about last year
> > cost us about $7 per shot.  But it's not just this, it's also AV
> > (microphones and projectors) and recording, and fast internet
> > access.  That all came to about $100k last year (or an extra $200
> > per head).  So you can see, running at the level Plumbers does
> > you're already looking at $540 a head, which, co-incidentally is
> > close to our attendee fee.  To get to $300 per head, you lot will
> > have to give up something in addition to the espresso machines,
> > what is it to be?
> 
> I was basing that on https://www.bsdcan.org/2020/registration.php
> which is a ~200 person conference, charging $200 for 2 days.  They
> provide morning & afternoon snacks as well as lunch and coffee.

I didn't say you couldn't run a conference for this low, I was just
point out what Plumbers currently costs.  FOSDEM clearly manages in
Europe for free, but what they have to give up is huge: No
tea/coffee/lunch/breakfast at all.  Doing it in a University helps with
A/V, and venue rental, but you're severely constrained by their
timetable (Ethan Miller did offer us UC Santa Cruz one year for LSF/MM
but we eventually concluded that date constraints and logistics would
just be too difficult).

James

