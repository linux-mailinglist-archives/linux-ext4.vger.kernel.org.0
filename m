Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A133C1EC7
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Jul 2021 07:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhGIFPU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Jul 2021 01:15:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229576AbhGIFPU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Jul 2021 01:15:20 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16954RP7181324;
        Fri, 9 Jul 2021 01:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Aa7UK6yxudfGII3bO8cUNwCvKD8TuC1HhJPVEWA8/LI=;
 b=MjT0+RSgqbLq2j8KpLsR0E01oCUaMBtEDyxTOxuf8y1CGFWidkblekjQAsrh6MRwGxmW
 dS/PLTVCudA1LpKifF0ft9GmwevL6KAZxhI3dX2tTYXcMTXfnTA9CT2BF/DifFdqU5Sb
 Ro50ZcRt58er+NiO1Tt+hD/ioA7b1L3SQYjOjmbDRd78zgecuNbnKdr740WXjL9DqpXG
 RqJL2yIGJySDWYTnBNCyHfrQaUa/Jacbg7JrwH5A2FmdHIzMacFBw+natHGiIFJUAdRS
 TcpwaMo3p2GL5ovEGGeQUOQNGGh3olf8ek/+diLHliLmGnQagqjI1nCrepefQe9d8/FA Cg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39nwfcryc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 01:12:34 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16959v74018845;
        Fri, 9 Jul 2021 05:12:33 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 39jfh8tg0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 05:12:33 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1695CUoF35193204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Jul 2021 05:12:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A87A4204D;
        Fri,  9 Jul 2021 05:12:30 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41A5A4203F;
        Fri,  9 Jul 2021 05:12:30 +0000 (GMT)
Received: from localhost (unknown [9.77.197.191])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Jul 2021 05:12:30 +0000 (GMT)
Date:   Fri, 9 Jul 2021 10:42:29 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 9/9] common/attr: Reduce MAX_ATTRS to leave some overhead
 for 64K blocksize
Message-ID: <20210709051229.psxw6fh4aaecuy6r@riteshh-domain>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
 <f23e6788b958849ec9c1fb7fed0081e58c02a13a.1623651783.git.riteshh@linux.ibm.com>
 <20210630155150.GC13743@locust>
 <YNzD90/uocoRveYq@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNzD90/uocoRveYq@mit.edu>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DZGzBAj7-ZSK5V7iKzf-SpQddVADdGzb
X-Proofpoint-ORIG-GUID: DZGzBAj7-ZSK5V7iKzf-SpQddVADdGzb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-09_01:2021-07-09,2021-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107090024
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/06/30 03:20PM, Theodore Ts'o wrote:
> On Wed, Jun 30, 2021 at 08:51:50AM -0700, Darrick J. Wong wrote:
> > On Mon, Jun 14, 2021 at 11:58:13AM +0530, Ritesh Harjani wrote:
> > > Test generic/020 fails for ext4 with 64K blocksize. So increase some overhead
> > > value to reduce the MAX_ATTRS so that it can accomodate for 64K blocksize.
> > >
> > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > > ---
> > >  common/attr | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/common/attr b/common/attr
> > > index d3902346..e8661d80 100644
> > > --- a/common/attr
> > > +++ b/common/attr
> > > @@ -260,7 +260,7 @@ xfs|udf|pvfs2|9p|ceph|nfs)
> > >  	# Assume max ~1 block of attrs
> > >  	BLOCK_SIZE=`_get_block_size $TEST_DIR`
> > >  	# user.attribute_XXX="value.XXX" is about 32 bytes; leave some overhead
> > > -	let MAX_ATTRS=$BLOCK_SIZE/40
> > > +	let MAX_ATTRS=$BLOCK_SIZE/48
> >
> > 50% is quite a lot of overhead; maybe we should special-case this?
>
> The problem is that 32 bytes is an underestimate when i > 99 for
> user.attribute_$i=value_$i.  And with a 4k blocksize, MAX_ATTRS =
> 4096 / 40 = 102.
>
> The exact calculation for ext4 is:
>
> fixed_block_overhead = 32
> fixed_entry_overhead = 16
> max_attr = (block_size - fixed_block_overhead) /
> 	(fixed_entry_overhead + round_up(len(attr_name), 4) +
> 	 round_up(len(value), 4))
>
> For 4k blocksizes, most of the attributes have an attr_name of
> "attribute_NN" which is 8, and "value_NN" which is 12.
>
> But for larger block sizes, we start having extended attributes of the
> form "attribute_NNN" or "attribute_NNNN", and "value_NNN" and
> "value_NNNN", which causes the round(len(..), 4) to jump up by 4
> bytes.  So round_up(len(attr_name, 4)) becomes 12 instead of 8, and
> round_up(len(value, 4)) becomes 16 instead of 12.  So:
>
> 	max_attrs = (block_size - 32) / (16 + 12 + 16)
> or
> 	max_attrs = (block_size - 32) / 44
>
> instead of:
>
> 	max_attrs = (block_size - 32) / (16 + 8 + 12)
> or
> 	max_attrs = (block_size - 32) / 36

Thanks for the indepth details. Yes, in my testing as well it was coming to be
around ~44%. But to be safe I chose 50%.
I verified from the code as well. We do have 32 bytes of overhead per block for
the the header. And per entry overhead of 16 bytes. The rounding happens for
both name (EXT4_XATTR_LEN) and value (EXT4_XATTR_SIZE) of attr.

Perhaps, it will be helpful if we update above info in ext4 documentation as
well. In that the rounding off is only mentioned for value and not for name
length.

>
> So special casing things for block sizes > 4k may very well make
> sense.  Perhaps it's even worth it to put in an ext[234] specific,
> exalc calculation for MAX_ATTRS in common/attr.

yes, will make these changes for ext[234] specific in common/attr.

-ritesh
