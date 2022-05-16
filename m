Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B6552801C
	for <lists+linux-ext4@lfdr.de>; Mon, 16 May 2022 10:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242008AbiEPIxW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 May 2022 04:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240906AbiEPIxU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 May 2022 04:53:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0865913EA6;
        Mon, 16 May 2022 01:53:19 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G7fOTk015201;
        Mon, 16 May 2022 08:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=xxf8nydfuoFkpTREIZCnApn7JKTJ8A7WGUCwv6+oPTM=;
 b=rzxw8uYK4hctvp4TVFG3yVyH8WLmPGuuVI7jvdty2mOAT2e9alFVzFsn4NtPEXv3bkAX
 J4sxwxgOUuA9+CZxBnq1eQdxdZEsdjvnOIuI6UGGrT7v2DlKMWrYRfCsNiEJ2Nu6bggz
 5zhA1NOkZkjc2fZ2eqCp4Iodri5rK3eekniLu9lDVWPl/J8JGdsg8pxxJwof80MRbiD8
 dvP7o2jbTxpUnQnvPTXwJJ4vmOMQT6ilmeRIwPnrUZL50Q+KIXjUyEhos49pnpBMdeNr
 mXPQGREGO1FRlD2qaT4kOpDlQdywqRyahgYF9+wtV7JTY8uyAShT28i/O9wnMoOwIn2j mg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3ey0d3mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 08:53:18 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24G8huuM023807;
        Mon, 16 May 2022 08:53:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3g23pj1t8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 08:53:17 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24G8rE3l53739806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 08:53:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B59765204F;
        Mon, 16 May 2022 08:53:14 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.41.34])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 5F36E52050;
        Mon, 16 May 2022 08:53:13 +0000 (GMT)
Date:   Mon, 16 May 2022 14:23:10 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     fstests@vger.kernel.org, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] common/rc: Modify _require_batched_discard to improve
 test coverage
Message-ID: <YoIQ9g/V0t18b5SB@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20220516063951.87838-1-ojaswin@linux.ibm.com>
 <20220516073616.x3sauzctypcxstet@zlang-mailbox>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516073616.x3sauzctypcxstet@zlang-mailbox>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wPcWMsCfDjJ4JIJVmFmWQ9Bd-ZrUBniC
X-Proofpoint-GUID: wPcWMsCfDjJ4JIJVmFmWQ9Bd-ZrUBniC
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_03,2022-05-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=445 spamscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205160049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> 
> Oh I forgot to ask why we need to add a variable (ret), to record the return
> value at here. Why can't use "$?" directly? e.g.
> 
>   grep -q "not supported" <($FSTRIM_PROG $1 2>&1)
>   if [ $? -eq 0 ]
> 
> Others look good to me.
> 
> Thanks,
> Zorro

That's right, I did it out of habbit. Anyways, I have eliminated the
variable and sent in a new version here [1]. Let me know if it looks
good.

Thank you!
Ojaswin

[1]
https://lore.kernel.org/all/20220516084505.97655-1-ojaswin@linux.ibm.com/
> 
> > +	then
> > +		_notrun "FITRIM not supported on $1"
> > +	fi
> >  }
> >  
> >  _require_dumpe2fs()
> > -- 
> > 2.27.0
> > 
> 
