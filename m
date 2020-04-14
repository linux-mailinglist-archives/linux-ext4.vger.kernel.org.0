Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A77D1A8C57
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Apr 2020 22:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633025AbgDNUU2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Apr 2020 16:20:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49248 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633019AbgDNUU1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Apr 2020 16:20:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EKI6DJ068660;
        Tue, 14 Apr 2020 20:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=kBixCm0Lp4xgEtRfMMtpHFUSc5P8Az1CT0L+J0eMpic=;
 b=DJI+TbrNZDm34an1OO8npTHA9saH76RVmYn+mixaRt0Dt/AgSREuWa9eX0I0FJrESAeO
 H+PoFMQaooWgdyZbGMqDTrg6RgiP4c5d5133iy7ls8mDqA3UH9bk48RGX0rCSHU362BQ
 6w4KXtHrM6QfmcmFA5ETiUrbQSobk/B08OYlxA9f63GiMDkleSjHv38UDXFR0av7q63k
 FWwYoZIQ1XhvjR000+YFnqBkRi1nJM8jl9EUm/NywzOmaxe1GcfcyauXuZGMcU00jAim
 dFStAhJQtalufZqynrrub/jXsLsvEzoSusFXj5k0EPWh4wZr/L2Ec3opfVOPkfVec7Gg Iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30b5um75m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 20:20:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EKGxwn010793;
        Tue, 14 Apr 2020 20:18:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30bqm2umvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 20:18:12 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03EKIACR030708;
        Tue, 14 Apr 2020 20:18:10 GMT
Received: from localhost (/10.159.239.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 13:18:10 -0700
Date:   Tue, 14 Apr 2020 13:18:08 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V7 9/9] Documentation/dax: Update Usage section
Message-ID: <20200414201808.GI6742@magnolia>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-10-ira.weiny@intel.com>
 <CAPcyv4g1gGWUuzVyOgOtkRTxzoSKOjVpAOmW-UDtmud9a3CUUA@mail.gmail.com>
 <20200414161509.GF6742@magnolia>
 <CAPcyv4hr+NKbpAU4UhKcmHfvDq1+GTM+y+K28XGbkDYBP=Kaag@mail.gmail.com>
 <20200414195754.GH6742@magnolia>
 <20200414200015.GF1853609@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414200015.GF1853609@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140143
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 14, 2020 at 01:00:15PM -0700, Ira Weiny wrote:
> On Tue, Apr 14, 2020 at 12:57:54PM -0700, Darrick J. Wong wrote:
> > On Tue, Apr 14, 2020 at 12:04:57PM -0700, Dan Williams wrote:
> > > On Tue, Apr 14, 2020 at 9:15 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> 
> [snip]
> 
> > > > > > +
> > > > > > +Enabling DAX on xfs
> > > > > > +-------------------
> > > > > > +
> > > > > > +Summary
> > > > > > +-------
> > > > > > +
> > > > > > + 1. There exists an in-kernel access mode flag S_DAX that is set when
> > > > > > +    file accesses go directly to persistent memory, bypassing the page
> > > > > > +    cache.
> > > > >
> > > > > I had reserved some quibbling with this wording, but now that this is
> > > > > being proposed as documentation I'll let my quibbling fly. "dax" may
> > > > > imply, but does not require persistent memory nor does it necessarily
> > > > > "bypass page cache". For example on configurations that support dax,
> > > > > but turn off MAP_SYNC (like virtio-pmem), a software flush is
> > > > > required. Instead, if we're going to define "dax" here I'd prefer it
> > > > > be a #include of the man page definition that is careful (IIRC) to
> > > > > only talk about semantics and not backend implementation details. In
> > > > > other words, dax is to page-cache as direct-io is to page cache,
> > > > > effectively not there, but dig a bit deeper and you may find it.
> > > >
> > > > Uh, which manpage?  Are you talking about the MAP_SYNC documentation?
> > > 
> > > No, I was referring to the proposed wording for STATX_ATTR_DAX.
> > > There's no reason for this description to say anything divergent from
> > > that description.
> > 
> > Ahh, ok.  Something like this, then:
> > 
> >  1. There exists an in-kernel access mode flag S_DAX.  When set, the
> >     file is in the DAX (cpu direct access) state.  DAX state attempts to
> >     minimize software cache effects for both I/O and memory mappings of
> >     this file.  The S_DAX state is exposed to userspace via the
> >     STATX_ATTR_DAX statx flag.
> > 
> >     See the STATX_ATTR_DAX in the statx(2) manpage for more information.
> 
> We crossed in the ether!!!  I propose even less details here...  Leave all the
> details to the man page.
> 
> <quote>
> 1. There exists an in-kernel access mode flag S_DAX that is set when file
>     accesses is enabled for 'DAX'.  Applications must call statx to discover
>     the current S_DAX state (STATX_ATTR_DAX).  See the man page for statx for
>     more details.
> </quote>

Why stop cutting there? :)

 1. There exists an in-kernel file access mode flag S_DAX that
    corresponds to the statx flag STATX_ATTR_DIRECT_LOAD_STORE.  See the
    manpage for statx(2) for details about this access mode.

--D

> Ira
> 
