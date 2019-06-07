Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA1C38400
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jun 2019 08:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfFGGAr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jun 2019 02:00:47 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42148 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfFGGAr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Jun 2019 02:00:47 -0400
Received: by mail-ot1-f66.google.com with SMTP id l15so800140otn.9
        for <linux-ext4@vger.kernel.org>; Thu, 06 Jun 2019 23:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/KxNQ9MI1VotM1MpZhO1sXWtsUgIvWtrmcpqkBhjppA=;
        b=WfyEYkZegPTmvynLc2fjjKs6d/TdRZHB2mGyi3svr8A4gfvWp7nBiukv2oNPMrRNu3
         LF5pIX9mWCDEYPKHsg9x8FyxTEXL3Pp4DEsbFXvMjA67etlGXIbfY2hNbJLOqw4TuZAK
         Bxvkt2hCh3F5rpXtMyj2CBZde6MBilulGBAwGobq2TdvBZsm+WUcNaCHcTKujMNYBYzA
         Jz+YlbRdrvtxV6qQh4bHw4H4UOWvGsLOnQyJmjDAnpMCiSaVTnMqJomtxlE/4a38CErg
         OEy8Ur6MMHV2bA7bkrmZl08c3aZp2RHd2Dpw55zuwf2rl9TE1d9/sN4lvF3IDzCodhLY
         IFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/KxNQ9MI1VotM1MpZhO1sXWtsUgIvWtrmcpqkBhjppA=;
        b=YQTFSb3dstSVWo431JYpZVNruvSfwR/sTmMVAJTJQaJp0XzHwdImQBX9+ZhItLpicz
         eONL5wbEYS7O7qhPTauUsqZH+Vpa0fEVQPcfXMUOtJquUhXk8kWW9b4gmhE8TLtFf2Pm
         sYT1HdsFAj7aogSz7XKXWnCBn44e5uorX7jEdMrjw2PIuJDF37mswU6xHPuMqZb6MToW
         mQrfp69rf+ICZJwfA+u/Wu6RHrI3s5zeIJoGvQMRvqvAQ+jdDkzvE+fTiH/wSAJJKLTa
         B9GIrTbFVlgfetn+4O9J/CAR8VDblHHKXvUKzcT2M+ND+tKfSIiowY7lU+OhKE+ckhE0
         EuXg==
X-Gm-Message-State: APjAAAWzvUugVU5uxLJ08Gnmfr7VlnGovBSMzjEA17U8TX1kCjd6nUTd
        1TDTTxFCBn9B1I7XyGwHck9U+kaiw5Mt5lCPodAtdg==
X-Google-Smtp-Source: APXvYqwgOBlvuuzB4VOYDbIT/0knuoEr43azK6XWvG7H+/gVjkfE0RSOiURNIXMgTP5DMZNdOklRtNkV5jBX8cvgDmo=
X-Received: by 2002:a9d:6e96:: with SMTP id a22mr17778966otr.207.1559887246873;
 Thu, 06 Jun 2019 23:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4jyCDJTpGZB6qVX7_FiaxJfDzWA1cw8dfPjHM2j3j3yqQ@mail.gmail.com>
 <20190214134622.GG4525@dhcp22.suse.cz> <CAPcyv4gxFKBQ9eVdn+pNEzBXRfw6Qwfmu21H2i5uj-PyFmRAGQ@mail.gmail.com>
 <20190214191013.GA3420@redhat.com> <CAPcyv4jLTdJyTOy715qvBL_j_deiLoBmu_thkUnFKZKMvZL6hA@mail.gmail.com>
 <20190214200840.GB12668@bombadil.infradead.org> <CAPcyv4hsDqvrV5yiDq8oWPuWb3WpuCEk_HB4qBxfiDpUwo75QQ@mail.gmail.com>
 <20190605162204.jzou5hry5exly5wx@fiona>
In-Reply-To: <20190605162204.jzou5hry5exly5wx@fiona>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 6 Jun 2019 23:00:35 -0700
Message-ID: <CAPcyv4gZSsAA+GE9otf=WfKSkGMcTbxgdgSCErNys4sOCdCzuA@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] The end of the DAX experiment
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        lsf-pc@lists.linux-foundation.org,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 5, 2019 at 9:22 AM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
>
> Hi Dan/Jerome,
>
> On 12:20 14/02, Dan Williams wrote:
> > On Thu, Feb 14, 2019 at 12:09 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Thu, Feb 14, 2019 at 11:31:24AM -0800, Dan Williams wrote:
> > > > On Thu, Feb 14, 2019 at 11:10 AM Jerome Glisse <jglisse@redhat.com> wrote:
> > > > > I am just again working on my struct page mapping patchset as well as
> > > > > the generic page write protection that sits on top. I hope to be able
> > > > > to post the v2 in couple weeks. You can always look at my posting last
> > > > > year to see more details.
> > > >
> > > > Yes, I have that in mind as one of the contenders. However, it's not
> > > > clear to me that its a suitable fit for filesystem-reflink. Others
> > > > have floated the 'page proxy' idea, so it would be good to discuss the
> > > > merits of the general approaches.
> > >
> > > ... and my preferred option of putting pfn entries in the page cache.
> >
> > Another option to include the discussion.
> >
> > > Or is that what you meant by "page proxy"?
> >
> > Page proxy would be an object that a filesystem could allocate to
> > point back to a single physical 'struct page *'. The proxy would
> > contain an override for page->index.
>
> Was there any outcome on this and its implementation? I am specifically
> interested in this for DAX support on btrfs/CoW: The TODO comment on
> top of dax_associate_entry() :)
>
> If there are patches/git tree I could use to base my patches on, it would
> be nice.

Half joking, but I was hoping that by the time I had circled back to
finally reviewing the brtfs dax patches that a solution to this
problem would be waiting. We spent more time on other DAX topics. I
recall that Jerome and I were mutually skeptical of each others
approaches at first glance, but we did not get into the details. So, I
think it will be a matter of getting the idea coded up. I'm finally
coming out from under a pile of mm work so I should have some time
this cycle to push the page proxy idea forward.
