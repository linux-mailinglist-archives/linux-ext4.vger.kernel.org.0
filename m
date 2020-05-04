Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C291C49B8
	for <lists+linux-ext4@lfdr.de>; Tue,  5 May 2020 00:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgEDWlH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 May 2020 18:41:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38898 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgEDWlH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 May 2020 18:41:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044MXnTu119421;
        Mon, 4 May 2020 22:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=aWMGPBvB5trisY77DWllsvp0PlV51hl2h1BGwXsgmGc=;
 b=Hhd3Vtx4dIlKLAXV2RkEW5zWyeexeCYIlcGEDKz+n9U/o3FALWuba9YBbKdPprg8Oe65
 kCGvMF2T2jmplCurZG6rtgF+/sD5rD3lVSgAoolbpiDS+OCeYLT4+Wmca40glsWI6ERC
 SF2PU6JjXg9qYCnuLIeS+wttdX/nqF0sv92CcDYU/WUFDXSdKS3VDXvPPvYLHe1ql0nS
 h9DzROHM66a/imKWKLJH9+aSzECzZZoSPGjaZvHUAfjk38JYYTt2jspS0A6pNQxr4128
 AxeE6VeyGnEhXiqbRqmbzfqbq3FAC9IhqJV5RMs6B+4tdMt6MF4h04voJNdktWqIo+1+ 0g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30s09r1r8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 22:41:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044Mae6I072734;
        Mon, 4 May 2020 22:39:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30sjjx345h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 22:39:03 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044Md2G3022313;
        Mon, 4 May 2020 22:39:02 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 15:39:02 -0700
Date:   Mon, 4 May 2020 15:39:00 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jonny Grant <jg@jguk.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: /fs/ext4/ext4.h add a comment to ext4_dir_entry_2
Message-ID: <20200504223900.GA5691@magnolia>
References: <bf50e54f-2a0c-17a4-89c3-4afcc298daeb@jguk.org>
 <1B91A6E6-7F4A-4C58-93E7-394217C1631C@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1B91A6E6-7F4A-4C58-93E7-394217C1631C@dilger.ca>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040176
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1011 suspectscore=1
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040176
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 04, 2020 at 04:26:35PM -0600, Andreas Dilger wrote:
> 
> > On May 3, 2020, at 6:52 AM, Jonny Grant <jg@jguk.org> wrote:
> > 
> > Hello
> > 
> > Could a comment be added to clarify 'file_type' ?
> > 
> > struct ext4_dir_entry_2 {
> >    __le32    inode;            /* Inode number */
> >    __le16    rec_len;        /* Directory entry length */
> >    __u8    name_len;        /* Name length */
> >    __u8    file_type;
> >    char    name[EXT4_NAME_LEN];    /* File name */
> > };
> > 
> > 
> > 
> > This what I am proposing to add:
> > 
> >    __u8    file_type;        /* See directory file type macros below */
> 
> For this kind of structure field, it makes sense to reference the macro
> names directly, like:
> 
> 	__u8	file_type;	/* See EXT4_FT_* type macros below */
> 
> since "macros below" may be ambiguous as the header changes over time.
> 
> 
> Even better (IMHO) is to use a named enum for this, like:
> 
>         enum ext4_file_type file_type:8; /* See EXT4_FT_ types below */
> 
> /*
>  * Ext4 directory file types.  Only the low 3 bits are used.  The
>  * other bits are reserved for now.
>  */
> enum ext4_file_type {
> 	EXT4_FT_UNKNOWN		= 0,
> 	EXT4_FT_REG_FILE	= 1,
> 	EXT4_FT_DIR		= 2,
> 	EXT4_FT_CHRDEV		= 3,
> 	EXT4_FT_BLKDEV		= 4,
> 	EXT4_FT_FIFO		= 5,
> 	EXT4_FT_SOCK		= 6,
> 	EXT4_FT_SYMLINK		= 7,
> 	EXT4_FT_MAX,
> 	EXT4_FT_DIR_CSUM	= 0xDE
> };
> 
> so that the allowed values for this field are clear from the definition.
> However, the use of a fixed-with bitfield (enum :8) is a GCC-ism and Ted
> may be against that for portability reasons, since the kernel and
> userspace headers should be as similar as possible.

This is an on-disk structure.  Do /not/ make this an enum because that
would replace a __u8 with an int, which will break directories.

--D

> Cheers, Andreas
> 
> 
> 
> 
> 


