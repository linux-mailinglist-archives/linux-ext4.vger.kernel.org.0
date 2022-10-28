Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A766D610F21
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Oct 2022 12:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiJ1Kzi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Oct 2022 06:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiJ1KzR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Oct 2022 06:55:17 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6BF2AC5D
        for <linux-ext4@vger.kernel.org>; Fri, 28 Oct 2022 03:55:11 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SAm8R3003109;
        Fri, 28 Oct 2022 10:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=iUN2yaz5zlZzxDJhT4/7nVWslNFatdW8SjXBSGuaODo=;
 b=PNMB3RZaOviPwaTc1StJj2dYT6YP3AkqCzwvSGBXtzzQSS0pWwjhgvPh2rECLyjMXiRF
 ifcONU6wQOq//6q/crgyfdgIoV5ACXk2mGWuvUG4KpkI0PcrnI5mxxaQpKOEfKikacIk
 56ckvtMeL3DbRaUB7DJt5Z3uEBepISasxFxBSbV9gIGEgXy+mvFL/VTYOm1TtyfrF4a/
 sIrcEsf4hJp9GJ2U0muVlRXwm+AsAD9dstC5nPdUns87gFn6fN7b9SlI3IEk+PHeJ8vN
 2sHiiDR7vSAXyrULiCwK9JnJ1ceqb9iEHUsutYuEe+lKBINAB02SJ2/f+ZcC43ZEzhLZ BA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kgdn606rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 10:55:01 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29SArAIt013497;
        Fri, 28 Oct 2022 10:54:59 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3kfahp2fqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 10:54:59 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29SAsvcj1770104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 10:54:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C4ADAE051;
        Fri, 28 Oct 2022 10:54:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D93FAE055;
        Fri, 28 Oct 2022 10:54:55 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.100.91])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 28 Oct 2022 10:54:55 +0000 (GMT)
Date:   Fri, 28 Oct 2022 16:24:52 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Jason Yan <yanaijie@huawei.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: make ext4_mb_initialize_context return void
Message-ID: <Y1u05l3L/gb/cSYg@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20221027032435.27374-1-guoqing.jiang@linux.dev>
 <bf9dba6f-50c6-5ba8-31e3-b60de18105f1@huawei.com>
 <23c58b71-8dbc-b314-de53-31e2593f94d4@linux.dev>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <23c58b71-8dbc-b314-de53-31e2593f94d4@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2RZ69ZQI_K9FlvSRpWTSQ19y2gpoqyia
X-Proofpoint-GUID: 2RZ69ZQI_K9FlvSRpWTSQ19y2gpoqyia
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_05,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 clxscore=1011 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 27, 2022 at 04:12:45PM +0800, Guoqing Jiang wrote:
> 
> 
> On 10/27/22 2:29 PM, Jason Yan wrote:
> > 
> > On 2022/10/27 11:24, Guoqing Jiang wrote:
> > > Change the return type to void since it always return 0, and no need
> > > to do the checking in ext4_mb_new_blocks.
> > > 
> > > Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> > > ---
> > >   fs/ext4/mballoc.c | 10 ++--------
> > >   1 file changed, 2 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > > index 9dad93059945..5b2ae37a8b80 100644
> > > --- a/fs/ext4/mballoc.c
> > > +++ b/fs/ext4/mballoc.c
> > > @@ -5204,7 +5204,7 @@ static void ext4_mb_group_or_file(struct
> > > ext4_allocation_context *ac)
> > >       mutex_lock(&ac->ac_lg->lg_mutex);
> > >   }
> > >   -static noinline_for_stack int
> > > +static noinline_for_stack void
> > >   ext4_mb_initialize_context(struct ext4_allocation_context *ac,
> > >                   struct ext4_allocation_request *ar)
> > >   {
> > > @@ -5253,8 +5253,6 @@ ext4_mb_initialize_context(struct
> > > ext4_allocation_context *ac,
> > >               (unsigned) ar->lleft, (unsigned) ar->pleft,
> > >               (unsigned) ar->lright, (unsigned) ar->pright,
> > >               inode_is_open_for_write(ar->inode) ? "" : "non-");
> > > -    return 0;
> > > -
> > >   }
> > >     static noinline_for_stack void
> > > @@ -5591,11 +5589,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
> > >           goto out;
> > >       }
> > >   -    *errp = ext4_mb_initialize_context(ac, ar);
> > > -    if (*errp) {
> > > -        ar->len = 0;
> > > -        goto out;
> > > -    }
> > > +    ext4_mb_initialize_context(ac, ar);
> > 
> > This changed the logic here slightly. *errp will not be intialized with
> > zero after this change. So we need to carefully check whether this will
> > cause any issues.
> 
> Yes, thanks for reminder. I think "*errp" is always set later with below.
> 
> https://elixir.bootlin.com/linux/v6.1-rc2/source/fs/ext4/mballoc.c#L5606
> https://elixir.bootlin.com/linux/v6.1-rc2/source/fs/ext4/mballoc.c#L5611
> https://elixir.bootlin.com/linux/v6.1-rc2/source/fs/ext4/mballoc.c#L5629
> https://elixir.bootlin.com/linux/v6.1-rc2/source/fs/ext4/mballoc.c#L5646
Hi Guoqing,

I agree, it seems to be intialized correctly later in the code. The
flow is something like:

  ext4_fsblk_t ext4_mb_new_blocks(...)
  {
      ...
      ext4_mb_initialize_context(ac, ar);
      ...
      if (!ext4_mb_use_preallocated(ac)) {
          *errp = ext4_mb_pa_alloc(ac);  // *errp init to 0 on success
          ...
      }

      if (likely(ac->ac_status == AC_STATUS_FOUND)) {
          // *errp init to 0 on success
          *errp = ext4_mb_mark_diskspace_used(ac, handle, reserv_clstrs);
          ...
      } else {
          ...
          *errp = -ENOSPC;
      }
      ...
  }

So it seems like this cleanup won't alter the behavior. Feel free to
add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin
